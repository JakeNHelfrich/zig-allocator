const std = @import("std");
const allocator = @import("./allocator.zig").stubbed_allocator;

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const ptr = try allocator.alloc(u8, 1);
    std.debug.print("Ptr: {any}\n", .{ptr[0]});
}
