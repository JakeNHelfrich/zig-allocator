const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn StubbedAllocator() type {
    return struct {
        pub const vtable: Allocator.VTable = .{
            .alloc = alloc,
            .resize = resize,
            .free = free,
        };

        fn alloc(_: *anyopaque, _: usize, _: u8, _: usize) ?[*]u8 {
            return null;
        }

        fn resize(_: *anyopaque, _: []u8, _: u8, _: usize, _: usize) bool {
            return false;
        }

        fn free(_: *anyopaque, _: []u8, _: u8, _: usize) void {}
    };
}

// TODO: Write tests