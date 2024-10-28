const std = @import("std");
const Allocator = std.mem.Allocator;

const failAllocator_vtable = Allocator.VTable{
    .alloc = failAllocatorAlloc,
    .resize = Allocator.noResize,
    .free = Allocator.noFree,
};

const fail_allocator = Allocator{
    .ptr = undefined,
    .vtable = &failAllocator_vtable,
};

fn failAllocatorAlloc(_: *anyopaque, n: usize, log2_alignment: u8, ra: usize) ?[*]u8 {
    _ = n;
    _ = log2_alignment;
    _ = ra;
    return null;
}

const testing = std.testing;
test "Allocator basics" {
    try testing.expectError(error.OutOfMemory, fail_allocator.alloc(u8, 1));
    try testing.expectError(error.OutOfMemory, fail_allocator.allocSentinel(u8, 1, 0));
}