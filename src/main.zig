const std = @import("std");
const allocator = @import("./allocator.zig").stubbed_allocator;

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const ptr1 = try heapAlloc(allocator, u8, 2);
    const ptr2 = try heapAlloc(allocator, u8, 3);
    std.debug.print("{d} {d}\n", .{ptr1.*, ptr2.*});
}

fn heapAlloc(alloc: anytype, comptime T: type, val: T) !*T {
    const ptr = try alloc.alloc(T, 1);
    ptr[0] = val;
    return @ptrCast(ptr);
}