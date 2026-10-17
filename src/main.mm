#import <UIKit/UIKit.h>
#include "executor.h"
#include "theme.h"
#include "logger.h"
@interface MasterV2Controller : UIViewController
@property (nonatomic, strong) UITextView *consoleView;
@property (nonatomic, strong) UIButton *runButton;
@end
@implementation MasterV2Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = get_terminal_background();
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, self.view.bounds.size.width - 40, 40)];
    header.text = @"ABSOLUTE BREAKMASTER V2 — LIVE";
    header.textColor = get_terminal_text_color();
    header.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:header];
    self.consoleView = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, 420)];
    self.consoleView.backgroundColor = [UIColor blackColor];
    self.consoleView.textColor = get_terminal_text_color();
    self.consoleView.font = get_terminal_font();
    self.consoleView.editable = NO;
    self.consoleView.text = @">>> Hệ thống V2 sẵn sàng. Nhấn nút để quét và thực thi lệnh trực tiếp...\n";
    [self.view addSubview:self.consoleView];
    self.runButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.runButton.frame = CGRectMake(20, self.view.bounds.size.height - 80, self.view.bounds.size.width - 40, 50);
    [self.runButton setTitle:@"CHẠY CHUỖI LỆNH HỆ THỐNG CHI TIẾT" forState:UIControlStateNormal];
    [self.runButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.runButton.backgroundColor = get_terminal_text_color();
    self.runButton.layer.cornerRadius = 10;
    [self.runButton addTarget:self action:@selector(executeSequenceActions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.runButton];
}
- (void)appendLog:(NSString * _Nonnull)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.consoleView.text = [NSString stringWithFormat:@"%@\n%@", self.consoleView.text, text];
        [self.consoleView scrollRangeToVisible:NSMakeRange(self.consoleView.text.length - 1, 1)];
    });
}
- (void)executeSequenceActions {
    [self appendLog:@">>> [1/4] Đang kiểm tra UID và đặc quyền tiến trình..."];
    uid_t current_uid = getuid();
    log_system_message([NSString stringWithFormat:@"Kiểm tra UID: %u", current_uid]);
   
    if (current_uid != 0) {
        [self appendLog:@"[-] Cảnh báo: Tiến trình chưa đạt quyền Root tối cao!"];
    } else {
        [self appendLog:@"[+] Xác thực thành công: Quyền Root tối cao (0)."];
    }
    [self appendLog:@">>> [2/4] Quét cấu trúc phân vùng tệp hệ thống..."];
    [self appendLog:execute_shell_command_live(@"mount")];
    [self appendLog:@">>> [3/4] Kiểm tra thông tin phiên bản kernel và không gian /var/jb..."];
    [self appendLog:execute_shell_command_live(@"uname -a && ls -la /var/jb")];
    [self appendLog:@">>> [4/4] Thực thi làm mới giao diện SpringBoard (sbreload)..."];
    [self appendLog:execute_shell_command_live(@"sbreload")];
    [self appendLog:@"[✓] Toàn bộ chuỗi lệnh đã được thực thi và báo cáo chi tiết thành công."];
}
@end
@interface MasterV2AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic, nullable) UIWindow *window;
@end
@implementation MasterV2AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    (void)application;
    (void)launchOptions;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MasterV2Controller *rootVC = [[MasterV2Controller alloc] init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
int main(int argc, char *argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([MasterV2AppDelegate class]));
    }
}
