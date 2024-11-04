const std = @import("std");
const Allocator = std.mem.Allocator;

// Get a pointer to a variable:
var number = [_]u8{ 35 };
const random_array_pointer: [*]u8 = number[0..1];

pub fn StubbedAllocator() type {
    return struct {
        pub const vtable: Allocator.VTable = .{
            .alloc = alloc,
            .resize = resize,
            .free = free,
        };

        fn alloc(_: *anyopaque, _: usize, _: u8, _: usize) ?[*]u8 {
            return random_array_pointer;
        }

        fn resize(_: *anyopaque, _: []u8, _: u8, _: usize, _: usize) bool {
            return false;
        }

        fn free(_: *anyopaque, _: []u8, _: u8, _: usize) void {}
    };
}

pub const stubbed_allocator = Allocator{
    .ptr = undefined,
    .vtable = &StubbedAllocator().vtable,
};

// TODO: Write tests