const std = @import("std");
const rl = @import("raylib");
const cl = @import("zclay");
const renderer = @import("raylib_render_clay.zig");

var syntax_image: rl.Texture2D = undefined;
var check_image1: rl.Texture2D = undefined;
var check_image2: rl.Texture2D = undefined;
var check_image3: rl.Texture2D = undefined;
var check_image4: rl.Texture2D = undefined;
var check_image5: rl.Texture2D = undefined;
var zig_logo_image6: rl.Texture2D = undefined;

var window_height: isize = 0;
var window_width: isize = 0;
var mobile_screen: bool = false;

const FONT_ID_BODY_16 = 0;
const FONT_ID_TITLE_52 = 1;
const FONT_ID_TITLE_48 = 2;
const FONT_ID_TITLE_36 = 3;
const FONT_ID_TITLE_32 = 4;
const FONT_ID_BODY_36 = 5;
const FONT_ID_BODY_30 = 6;
const FONT_ID_BODY_28 = 7;
const FONT_ID_BODY_24 = 8;
const FONT_ID_TITLE_56 = 9;

const COLOR_LIGHT = cl.Color{ 244, 235, 230, 255 };
const COLOR_LIGHT_HOVER = cl.Color{ 224, 215, 210, 255 };
const COLOR_BUTTON_HOVER = cl.Color{ 238, 227, 225, 255 };
const COLOR_BROWN = cl.Color{ 61, 26, 5, 255 };
const COLOR_RED = cl.Color{ 168, 66, 28, 255 };
const COLOR_RED_HOVER = cl.Color{ 148, 46, 8, 255 };
const COLOR_ORANGE = cl.Color{ 225, 138, 50, 255 };
const COLOR_BLUE = cl.Color{ 111, 173, 162, 255 };
const COLOR_TEAL = cl.Color{ 111, 173, 162, 255 };
const COLOR_BLUE_DARK = cl.Color{ 2, 32, 82, 255 };
const COLOR_ZIG_LOGO = cl.Color{ 247, 164, 29, 255 };

// Colors for top stripe
const COLORS_TOP_BORDER = [_]cl.Color{
    .{ 240, 213, 137, 255 },
    .{ 236, 189, 80, 255 },
    .{ 225, 138, 50, 255 },
    .{ 223, 110, 44, 255 },
    .{ 168, 66, 28, 255 },
};

const COLOR_BLOB_BORDER_1 = cl.Color{ 168, 66, 28, 255 };
const COLOR_BLOB_BORDER_2 = cl.Color{ 203, 100, 44, 255 };
const COLOR_BLOB_BORDER_3 = cl.Color{ 225, 138, 50, 255 };
const COLOR_BLOB_BORDER_4 = cl.Color{ 236, 159, 70, 255 };
const COLOR_BLOB_BORDER_5 = cl.Color{ 240, 189, 100, 255 };

const border_data = cl.BorderData{ .width = 2, .color = COLOR_RED };

fn landingPageBlob(index: u32, font_size: u16, font_id: u16, color: cl.Color, image_size: f32, width: f32, text: []const u8, image: *rl.Texture2D) void {
    cl.UI()(.{
        .id = .IDI("HeroBlob", index),
        .layout = .{ .sizing = .{ .w = .growMinMax(.{ .max = width }) }, .padding = .all(16), .child_gap = 16, .child_alignment = .{ .y = .center } },
        .border = .{ .width = .outside(2), .color = color },
        .corner_radius = .all(10),
    })({
        cl.UI()(.{ .id = .IDI("CheckImage", index), .layout = .{ .sizing = .{ .w = .fixed(image_size) } }, .aspect_ratio = .{ .aspect_ratio = 128 / 128 }, .image = .{ .image_data = image } })({});
        cl.text(text, .{ .font_size = font_size, .font_id = font_id, .color = color });
    });
}

fn landingPageDesktop() void {
    cl.UI()(.{
        .id = .ID("LandingPage1Desktop"),
        .layout = .{ .sizing = .{ .w = .grow, .h = .fitMinMax(.{ .min = @floatFromInt(window_height - 70) }) }, .child_alignment = .{ .y = .center }, .padding = .{ .left = 50, .right = 50 } },
    })({
        cl.UI()(.{
            .id = .ID("LandingPage1"),
            .layout = .{ .sizing = .{ .w = .grow, .h = .grow }, .direction = .top_to_bottom, .child_alignment = .{ .x = .center }, .padding = .all(32), .child_gap = 32 },
            .border = .{ .width = .{ .left = 2, .right = 2 }, .color = COLOR_RED },
        })({
            landingPageBlob(0, 30, FONT_ID_BODY_30, COLOR_ZIG_LOGO, 64, 510, "The official Clay website recreated with zclay: clay-zig-bindings", &zig_logo_image6);
            cl.UI()(.{ .id = .ID("ClayPresentation"), .layout = .{ .sizing = .grow, .child_alignment = .{ .y = .center }, .child_gap = 16 } })({
                cl.UI()(.{
                    .id = .ID("LeftText"),
                    .layout = .{ .sizing = .{ .w = .percent(0.55) }, .direction = .top_to_bottom, .child_gap = 8 },
                })({
                    cl.text("Clay is a flex-box style UI auto layout library in C, with declarative syntax and microsecond performance.", .{ .font_size = 56, .font_id = FONT_ID_TITLE_56, .color = COLOR_RED });
                    cl.UI()(.{ .layout = .{ .sizing = .{ .w = .grow, .h = .fixed(32) } } })({});
                    cl.text("Clay is laying out this webpage right now!", .{ .font_size = 36, .font_id = FONT_ID_BODY_36, .color = COLOR_ORANGE });
                });

                cl.UI()(.{
                    .id = .ID("HeroImageOuter"),
                    .layout = .{ .sizing = .{ .w = .percent(0.45) }, .direction = .top_to_bottom, .child_alignment = .{ .x = .center }, .child_gap = 16 },
                })({
                    landingPageBlob(1, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_5, 32, 480, "High performance", &check_image5);
                    landingPageBlob(2, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_4, 32, 480, "Flexbox-style responsive layout", &check_image4);
                    landingPageBlob(3, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_3, 32, 480, "Declarative syntax", &check_image3);
                    landingPageBlob(4, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_2, 32, 480, "Single .h file for C/C++", &check_image2);
                    landingPageBlob(5, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_1, 32, 480, "Compile to 15kb .wasm", &check_image1);
                });
            });
        });
    });
}

fn landingPageMobile() void {
    cl.UI()(.{
        .id = .ID("LandingPage1Mobile"),
        .layout = .{
            .sizing = .{ .w = .grow, .h = .fitMinMax(.{ .min = @floatFromInt(window_height - 70) }) },
            .direction = .top_to_bottom,
            .child_alignment = .center,
            .padding = .{ .left = 16, .right = 16, .top = 32, .bottom = 32 },
            .child_gap = 16,
        },
    })({
        landingPageBlob(0, 30, FONT_ID_BODY_30, COLOR_ZIG_LOGO, 64, 510, "The official Clay website recreated with zclay: clay-zig-bindings", &zig_logo_image6);
        cl.UI()(.{
            .id = .ID("LeftText"),
            .layout = .{ .sizing = .{ .w = .grow }, .direction = .top_to_bottom, .child_gap = 8 },
        })({
            cl.text("Clay is a flex-box style UI auto layout library in C, with declarative syntax and microsecond performance.", .{ .font_size = 56, .font_id = FONT_ID_TITLE_56, .color = COLOR_RED });
            cl.UI()(.{ .layout = .{ .sizing = .{ .w = .grow, .h = .fixed(32) } } })({});
            cl.text("Clay is laying out this webpage .right now!", .{ .font_size = 36, .font_id = FONT_ID_BODY_36, .color = COLOR_ORANGE });
        });

        cl.UI()(.{
            .id = .ID("HeroImageOuter"),
            .layout = .{ .sizing = .{ .w = .grow }, .direction = .top_to_bottom, .child_alignment = .{ .x = .center }, .child_gap = 16 },
        })({
            landingPageBlob(1, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_5, 32, 480, "High performance", &check_image5);
            landingPageBlob(2, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_4, 32, 480, "Flexbox-style responsive layout", &check_image4);
            landingPageBlob(3, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_3, 32, 480, "Declarative syntax", &check_image3);
            landingPageBlob(4, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_2, 32, 480, "Single .h file for C/C++", &check_image2);
            landingPageBlob(5, 30, FONT_ID_BODY_30, COLOR_BLOB_BORDER_1, 32, 480, "Compile to 15kb .wasm", &check_image1);
        });
    });
}

fn featureBlocks(width_sizing: cl.SizingAxis, outer_padding: u16) void {
    const text_config = cl.TextElementConfig{ .font_size = 24, .font_id = FONT_ID_BODY_24, .color = COLOR_RED };
    cl.UI()(.{
        .id = .ID("HFileBoxOuter"),
        .layout = .{
            .direction = .top_to_bottom,
            .sizing = .{ .w = width_sizing },
            .child_alignment = .{ .y = .center },
            .padding = .{ .left = outer_padding, .right = outer_padding, .top = 32, .bottom = 32 },
            .child_gap = 8,
        },
    })({
        cl.UI()(.{
            .id = .ID("HFileIncludeOuter"),
            .layout = .{ .padding = .{ .left = 8, .right = 8, .top = 4, .bottom = 4 } },
            .background_color = COLOR_RED,
            .corner_radius = .all(8),
        })({
            cl.text("#include cl.h", .{ .font_size = 24, .font_id = FONT_ID_BODY_24, .color = COLOR_LIGHT });
        });
        cl.text("~2000 lines of C99.", text_config);
        cl.text("Zero dependencies, including no C standard library", text_config);
    });
    cl.UI()(.{
        .id = .ID("BringYourOwnRendererOuter"),
        .layout = .{
            .direction = .top_to_bottom,
            .sizing = .{ .w = width_sizing },
            .child_alignment = .{ .y = .center },
            .padding = .{ .left = outer_padding, .right = outer_padding, .top = 32, .bottom = 32 },
            .child_gap = 8,
        },
    })({
        cl.text("Renderer agnostic.", .{ .font_size = 24, .font_id = FONT_ID_BODY_24, .color = COLOR_ORANGE });
        cl.text("Layout with clay, then render with Raylib, WebGL Canvas or even as HTML.", text_config);
        cl.text("Flexible output for easy compositing in your custom engine or environment.", text_config);
    });
}

fn featureBlocksDesktop() void {
    cl.UI()(.{
        .id = .ID("FeatureBlocksOuter"),
        .layout = .{ .sizing = .{ .w = .grow }, .child_alignment = .{ .y = .center } },
        .border = .{ .width = .{ .between_children = 2 }, .color = COLOR_RED },
    })({
        featureBlocks(.percent(0.5), 50);
    });
}

fn featureBlocksMobile() void {
    cl.UI()(.{
        .id = .ID("FeatureBlocksOuter"),
        .layout = .{ .sizing = .{ .w = .grow }, .direction = .top_to_bottom },
        .border = .{ .width = .{ .between_children = 2 }, .color = COLOR_RED },
    })({
        featureBlocks(.grow, 16);
    });
}

fn declarativeSyntaxPage(title_text_config: cl.TextElementConfig, width_sizing: cl.SizingAxis) void {
    cl.UI()(.{ .id = .ID("SyntaxPageLeftText"), .layout = .{ .sizing = .{ .w = width_sizing }, .direction = .top_to_bottom, .child_gap = 8 } })({
        cl.text("Declarative Syntax", title_text_config);
        cl.UI()(.{ .layout = .{ .sizing = .{ .w = .growMinMax(.{ .max = 16 }) } } })({});
        const text_conf = cl.TextElementConfig{ .font_size = 28, .font_id = FONT_ID_BODY_28, .color = COLOR_RED };
        cl.text("Flexible and readable declarative syntax with nested UI element hierarchies.", text_conf);
        cl.text("Mix elements with standard C code like loops, conditionals and functions.", text_conf);
        cl.text("Create your own library of re-usable components from UI primitives like text, images and rectangles.", text_conf);
    });
    cl.UI()(.{ .id = .ID("SyntaxPageRightImageOuter"), .layout = .{ .sizing = .{ .w = width_sizing }, .child_alignment = .{ .x = .center } } })({
        cl.UI()(.{
            .id = .ID("SyntaxPageRightImage"),
            .layout = .{ .sizing = .{ .w = .growMinMax(.{ .max = 568 }) } },
            .aspect_ratio = .{ .aspect_ratio = 1194 / 1136 },
            .image = .{ .image_data = &syntax_image },
        })({});
    });
}

fn declarativeSyntaxPageDesktop() void {
    cl.UI()(.{
        .id = .ID("SyntaxPageDesktop"),
        .layout = .{ .sizing = .{ .w = .grow, .h = .fitMinMax(.{ .min = @floatFromInt(window_height - 50) }) }, .child_alignment = .{ .y = .center }, .padding = .{ .left = 50, .right = 50 } },
    })({
        cl.UI()(.{
            .id = .ID("SyntaxPage"),
            .layout = .{ .sizing = .{ .w = .grow, .h = .grow }, .child_alignment = .{ .y = .center }, .padding = .all(32), .child_gap = 32 },
            .border = .{ .width = .{ .left = 2, .right = 2 }, .color = COLOR_RED },
        })({
            declarativeSyntaxPage(.{ .font_size = 52, .font_id = FONT_ID_TITLE_52, .color = COLOR_RED }, .percent(0.5));
        });
    });
}

fn declarativeSyntaxPageMobile() void {
    cl.UI()(.{
        .id = .ID("SyntaxPageMobile"),
        .layout = .{
            .direction = .top_to_bottom,
            .sizing = .{ .w = .grow, .h = .fitMinMax(.{ .min = @floatFromInt(window_height - 50) }) },
            .child_alignment = .center,
            .padding = .{ .left = 16, .right = 16, .top = 32, .bottom = 32 },
            .child_gap = 16,
        },
    })({
        declarativeSyntaxPage(.{ .font_size = 48, .font_id = FONT_ID_TITLE_48, .color = COLOR_RED }, .grow);
    });
}

fn colorLerp(a: cl.Color, b: cl.Color, amount: f32) cl.Color {
    return cl.Color{ a[0] + (b[0] - a[0]) * amount, a[1] + (b[1] - a[1]) * amount, a[2] + (b[2] - a[2]) * amount, a[3] + (b[3] - a[3]) * amount };
}

const LOREM_IPSUM_TEXT = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

fn highPerformancePage(lerp_value: f32, title_text_tonfig: cl.TextElementConfig, width_sizing: cl.SizingAxis) void {
    cl.UI()(.{ .id = .ID("PerformanceLeftText"), .layout = .{ .sizing = .{ .w = width_sizing }, .direction = .top_to_bottom, .child_gap = 8 } })({
        cl.text("High Performance", title_text_tonfig);
        cl.UI()(.{ .layout = .{ .sizing = .{ .w = .growMinMax(.{ .max = 16 }) } } })({});
        cl.text("Fast enough to recompute your entire UI every frame.", .{ .font_size = 28, .font_id = FONT_ID_BODY_36, .color = COLOR_LIGHT });
        cl.text("Small memory footprint (3.5mb default) with static allocation & reuse. No malloc / free.", .{ .font_size = 28, .font_id = FONT_ID_BODY_36, .color = COLOR_LIGHT });
        cl.text("Simplify animations and reactive UI design by avoiding the standard performance hacks.", .{ .font_size = 28, .font_id = FONT_ID_BODY_36, .color = COLOR_LIGHT });
    });
    cl.UI()(.{ .id = .ID("PerformanceRightImageOuter"), .layout = .{ .sizing = .{ .w = width_sizing }, .child_alignment = .{ .x = .center } } })({
        cl.UI()(.{
            .id = .ID("PerformanceRightBorder"),
            .layout = .{ .sizing = .{ .w = .grow, .h = .fixed(400) } },
            .border = .{ .width = .all(2), .color = COLOR_LIGHT },
        })({
            cl.UI()(.{
                .id = .ID("AnimationDemoContainerLeft"),
                .layout = .{ .sizing = .{ .w = .percent(0.35 + 0.3 * lerp_value), .h = .grow }, .child_alignment = .{ .y = .center }, .padding = .all(16) },
                .background_color = colorLerp(COLOR_RED, COLOR_ORANGE, lerp_value),
            })({
                cl.text(LOREM_IPSUM_TEXT, .{ .font_size = 16, .font_id = FONT_ID_BODY_16, .color = COLOR_LIGHT });
            });

            cl.UI()(.{
                .id = .ID("AnimationDemoContainerRight"),
                .layout = .{ .sizing = .{ .w = .grow, .h = .grow }, .child_alignment = .{ .y = .center }, .padding = .all(16) },
                .background_color = colorLerp(COLOR_ORANGE, COLOR_RED, lerp_value),
            })({
                cl.text(LOREM_IPSUM_TEXT, .{ .font_size = 16, .font_id = FONT_ID_BODY_16, .color = COLOR_LIGHT });
            });
        });
    });
}

fn highPerformancePageDesktop(lerp_value: f32) void {
    cl.UI()(.{
        .id = .ID("PerformanceDesktop"),
        .layout = .{
            .sizing = .{ .w = .grow, .h = .fitMinMax(.{ .min = @floatFromInt(window_height - 50) }) },
            .child_alignment = .{ .y = .center },
            .padding = .{ .left = 82, .right = 82, .top = 32, .bottom = 32 },
            .child_gap = 64,
        },
        .background_color = COLOR_RED,
    })({
        highPerformancePage(lerp_value, .{ .font_size = 52, .font_id = FONT_ID_TITLE_52, .color = COLOR_LIGHT }, .percent(0.5));
    });
}

fn highPerformancePageMobile(lerp_value: f32) void {
    cl.UI()(.{
        .id = .ID("PerformanceMobile"),
        .layout = .{
            .direction = .top_to_bottom,
            .sizing = .{ .w = .grow, .h = .fitMinMax(.{ .min = @floatFromInt(window_height - 50) }) },
            .child_alignment = .center,
            .padding = .{ .left = 16, .right = 16, .top = 32, .bottom = 32 },
            .child_gap = 32,
        },
        .background_color = COLOR_RED,
    })({
        highPerformancePage(lerp_value, .{ .font_size = 48, .font_id = FONT_ID_TITLE_48, .color = COLOR_LIGHT }, .grow);
    });
}

fn rendererButtonActive(text: []const u8) void {
    cl.UI()(.{
        .layout = .{ .sizing = .{ .w = .fixed(300) }, .padding = .all(16) },
        .background_color = COLOR_RED,
        .corner_radius = .all(10),
    })({
        cl.text(text, .{ .font_size = 28, .font_id = FONT_ID_BODY_28, .color = COLOR_LIGHT });
    });
}

fn rendererButtonInactive(index: u32, text: []const u8) void {
    cl.UI()(.{ .layout = .{}, .border = .outside(.{ 2, COLOR_RED }, 10) })({
        cl.UI()(.{
            .id = .ID("RendererButtonInactiveInner", index),
            .layout = .{ .sizing = .{ .w = .fixed(300) }, .padding = .all(16) },
            .background_color = COLOR_LIGHT,
            .corner_radius = .all(10),
        })({
            cl.text(text, .{ .font_size = 28, .font_id = FONT_ID_BODY_28, .color = COLOR_RED });
        });
    });
}

fn rendererPage(title_text_config: cl.TextElementConfig, width_sizing: cl.SizingAxis) void {
    cl.UI()(.{ .id = .ID("RendererLeftText"), .layout = .{ .sizing = .{ .w = width_sizing }, .direction = .top_to_bottom, .child_gap = 8 } })({
        cl.text("Renderer & Platform Agnostic", title_text_config);
        cl.UI()(.{ .layout = .{ .sizing = .{ .w = .growMinMax(.{ .max = 16 }) } } })({});
        cl.text("Clay outputs a sorted array of primitive render commands, such as RECTANGLE, TEXT or IMAGE.", .{ .font_size = 28, .font_id = FONT_ID_BODY_36, .color = COLOR_RED });
        cl.text("Write your own renderer in a few hundred lines of code, or use the provided examples for Raylib, WebGL canvas and more.", .{ .font_size = 28, .font_id = FONT_ID_BODY_36, .color = COLOR_RED });
        cl.text("There's even an HTML renderer - you're looking at it right now!", .{ .font_size = 28, .font_id = FONT_ID_BODY_36, .color = COLOR_RED });
    });
    cl.UI()(.{
        .id = .ID("RendererRightText"),
        .layout = .{ .sizing = .{ .w = width_sizing }, .child_alignment = .{ .x = .center }, .direction = .top_to_bottom, .child_gap = 16 },
    })({
        cl.text("Try changing renderer!", .{ .font_size = 36, .font_id = FONT_ID_BODY_36, .color = COLOR_ORANGE });
        cl.UI()(.{ .layout = .{ .sizing = .{ .w = .growMinMax(.{ .max = 32 }) } } })({});
        rendererButtonActive("Raylib Renderer");
    });
}

fn rendererPageDesktop() void {
    cl.UI()(.{
        .id = .ID("RendererPageDesktop"),
        .layout = .{ .sizing = .{ .w = .grow, .h = .fitMinMax(.{ .min = @floatFromInt(window_height - 50) }) }, .child_alignment = .{ .y = .center }, .padding = .{ .left = 50, .right = 50 } },
    })({
        cl.UI()(.{
            .id = .ID("RendererPage"),
            .layout = .{ .sizing = .grow, .child_alignment = .{ .y = .center }, .padding = .all(32), .child_gap = 32 },
            .border = .{ .width = .{ .left = 2, .right = 2 }, .color = COLOR_RED },
        })({
            rendererPage(.{ .font_size = 52, .font_id = FONT_ID_TITLE_52, .color = COLOR_RED }, .percent(0.5));
        });
    });
}

fn rendererPageMobile() void {
    cl.UI()(.{
        .id = .ID("RendererMobile"),
        .layout = .{
            .direction = .top_to_bottom,
            .sizing = .{ .w = .grow, .h = .fitMinMax(.{ .min = @floatFromInt(window_height - 50) }) },
            .child_alignment = .center,
            .padding = .{ .left = 16, .right = 16, .top = 32, .bottom = 32 },
            .child_gap = 32,
        },
        .background_color = COLOR_LIGHT,
    })({
        rendererPage(.{ .font_size = 52, .font_id = FONT_ID_TITLE_52, .color = COLOR_RED }, .grow);
    });
}

fn createLayout(lerp_value: f32) []cl.RenderCommand {
    cl.beginLayout();
    cl.UI()(.{
        .id = .ID("OuterContainer"),
        .layout = .{ .sizing = .grow, .direction = .top_to_bottom },
        .background_color = COLOR_LIGHT,
    })({
        cl.UI()(.{
            .id = .ID("Header"),
            .layout = .{ .sizing = .{ .h = .fixed(50), .w = .grow }, .child_alignment = .{ .y = .center }, .padding = .{ .left = 32, .right = 32 }, .child_gap = 24 },
        })({
            cl.text("Clay", .{ .font_id = FONT_ID_BODY_24, .font_size = 24, .color = .{ 61, 26, 5, 255 } });
            cl.UI()(.{ .layout = .{ .sizing = .{ .w = .grow } } })({});

            if (!mobile_screen) {
                cl.UI()(.{ .id = .ID("LinkExamplesInner"), .layout = .{}, .background_color = .{ 0, 0, 0, 0 } })({
                    cl.text("Examples", .{ .font_id = FONT_ID_BODY_24, .font_size = 24, .color = .{ 61, 26, 5, 255 } });
                });
                cl.UI()(.{ .id = .ID("LinkDocsOuter"), .layout = .{}, .background_color = .{ 0, 0, 0, 0 } })({
                    cl.text("Docs", .{ .font_id = FONT_ID_BODY_24, .font_size = 24, .color = .{ 61, 26, 5, 255 } });
                });
            }

            cl.UI()(.{
                .layout = .{ .padding = .{ .left = 32, .right = 32, .top = 6, .bottom = 6 } },
                .border = .{ .width = .all(2), .color = COLOR_RED },
                .corner_radius = .all(10),
                .background_color = if (cl.hovered()) COLOR_LIGHT_HOVER else COLOR_LIGHT,
            })({
                cl.text("Github", .{ .font_id = FONT_ID_BODY_24, .font_size = 24, .color = .{ 61, 26, 5, 255 } });
            });
        });
        for (COLORS_TOP_BORDER, 0..) |color, i| {
            cl.UI()(.{
                .id = .IDI("TopBorder", @intCast(i)),
                .layout = .{ .sizing = .{ .h = .fixed(4), .w = .grow } },
                .background_color = color,
            })({});
        }

        cl.UI()(.{
            .id = .fromSrc(@src()),
            .clip = .{ .vertical = true, .child_offset = cl.getScrollOffset() },
            .layout = .{ .sizing = .grow, .direction = .top_to_bottom },
            .background_color = COLOR_LIGHT,
            .border = .{ .width = .{ .between_children = 2 }, .color = COLOR_RED },
        })({
            if (!mobile_screen) {
                landingPageDesktop();
                featureBlocksDesktop();
                declarativeSyntaxPageDesktop();
                highPerformancePageDesktop(lerp_value);
                rendererPageDesktop();
            } else {
                landingPageMobile();
                featureBlocksMobile();
                declarativeSyntaxPageMobile();
                highPerformancePageMobile(lerp_value);
                rendererPageMobile();
            }
        });
    });
    return cl.endLayout();
}

fn loadFont(file_data: ?[]const u8, font_id: u16, font_size: i32) !void {
    renderer.raylib_fonts[font_id] = try rl.loadFontFromMemory(".ttf", file_data, font_size * 2, null);
    rl.setTextureFilter(renderer.raylib_fonts[font_id].?.texture, .bilinear);
}

fn loadImage(comptime path: [:0]const u8) !rl.Texture2D {
    const texture = try rl.loadTextureFromImage(try rl.loadImageFromMemory(@ptrCast(std.fs.path.extension(path)), @embedFile(path)));
    rl.setTextureFilter(texture, .bilinear);
    return texture;
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    // init clay
    const min_memory_size: u32 = cl.minMemorySize();
    const memory = try allocator.alloc(u8, min_memory_size);
    defer allocator.free(memory);
    const arena: cl.Arena = cl.createArenaWithCapacityAndMemory(memory);
    _ = cl.initialize(arena, .{ .h = 1000, .w = 1000 }, .{});
    cl.setMeasureTextFunction(void, {}, renderer.measureText);

    // init raylib
    rl.setConfigFlags(.{
        .msaa_4x_hint = true,
        .window_resizable = true,
    });
    rl.initWindow(1000, 1000, "Raylib zig Example");
    rl.setTargetFPS(60);

    // load assets
    try loadFont(@embedFile("resources/Calistoga-Regular.ttf"), FONT_ID_TITLE_56, 56);
    try loadFont(@embedFile("resources/Calistoga-Regular.ttf"), FONT_ID_TITLE_52, 52);
    try loadFont(@embedFile("resources/Calistoga-Regular.ttf"), FONT_ID_TITLE_48, 48);
    try loadFont(@embedFile("resources/Calistoga-Regular.ttf"), FONT_ID_TITLE_36, 36);
    try loadFont(@embedFile("resources/Calistoga-Regular.ttf"), FONT_ID_TITLE_32, 32);
    try loadFont(@embedFile("resources/Quicksand-Semibold.ttf"), FONT_ID_BODY_36, 36);
    try loadFont(@embedFile("resources/Quicksand-Semibold.ttf"), FONT_ID_BODY_30, 30);
    try loadFont(@embedFile("resources/Quicksand-Semibold.ttf"), FONT_ID_BODY_28, 28);
    try loadFont(@embedFile("resources/Quicksand-Semibold.ttf"), FONT_ID_BODY_24, 24);
    try loadFont(@embedFile("resources/Quicksand-Semibold.ttf"), FONT_ID_BODY_16, 16);

    syntax_image = try loadImage("resources/declarative.png");
    check_image1 = try loadImage("resources/check_1.png");
    check_image2 = try loadImage("resources/check_2.png");
    check_image3 = try loadImage("resources/check_3.png");
    check_image4 = try loadImage("resources/check_4.png");
    check_image5 = try loadImage("resources/check_5.png");
    zig_logo_image6 = try loadImage("resources/zig-mark.png");

    var animation_lerp_value: f32 = -1.0;
    var debug_mode_enabled = false;
    while (!rl.windowShouldClose()) {
        if (rl.isKeyPressed(.d)) {
            debug_mode_enabled = !debug_mode_enabled;
            cl.setDebugModeEnabled(debug_mode_enabled);
        }

        animation_lerp_value += rl.getFrameTime();
        if (animation_lerp_value > 1) {
            animation_lerp_value = animation_lerp_value - 2;
        }

        window_width = rl.getScreenWidth();
        window_height = rl.getScreenHeight();
        mobile_screen = (window_width - if (debug_mode_enabled) @as(i32, @intCast(cl.Clay__debugViewWidth)) else 0) < 750;

        const mouse_pos = rl.getMousePosition();
        cl.setPointerState(.{
            .x = mouse_pos.x,
            .y = mouse_pos.y,
        }, rl.isMouseButtonDown(.left));

        const scroll_delta = rl.getMouseWheelMoveV().multiply(.{ .x = 6, .y = 6 });
        cl.updateScrollContainers(
            false,
            .{ .x = scroll_delta.x, .y = scroll_delta.y },
            rl.getFrameTime(),
        );

        cl.setLayoutDimensions(.{ .w = @floatFromInt(window_width), .h = @floatFromInt(window_height) });
        const render_commands = createLayout(if (animation_lerp_value < 0) animation_lerp_value + 1 else 1 - animation_lerp_value);

        rl.beginDrawing();
        try renderer.clayRaylibRender(render_commands, allocator);
        rl.endDrawing();
    }
}
