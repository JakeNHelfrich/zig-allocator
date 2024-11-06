const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn MyAllocator() type {
    return struct {
        pub const vtable: Allocator.VTable = .{
            .alloc = alloc,
            .resize = resize,
            .free = free,
        };

        fn alloc(_: *anyopaque, len: usize, _: u8, _: usize) ?[*]u8 {
            const ptr = std.posix.mmap(
                null,
                len,
                std.posix.PROT.READ | std.posix.PROT.WRITE,
                .{ .TYPE = .PRIVATE, .ANONYMOUS = true },
                -1,
                0
            ) catch null;
            return @ptrCast(ptr);
        }

        fn resize(_: *anyopaque, _: []u8, _: u8, _: usize, _: usize) bool {
            return false;
        }

        fn free(_: *anyopaque, _: []u8, _: u8, _: usize) void {}
    };
}

pub const stubbed_allocator = Allocator{
    .ptr = undefined,
    .vtable = &MyAllocator().vtable,
};

// TODO: Write tests