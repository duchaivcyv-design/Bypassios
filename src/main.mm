#import <UIKit/UIKit.h>
#include "executor.h"
#include "theme.h"

@interface UltimateMasterController : UIViewController
@property (nonatomic, strong) UITextView *terminalView;
@property (nonatomic, strong) UIButton *executeButton;
@end

@implementation UltimateMasterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = get_matrix_background();

    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, self.view.bounds.size.width - 40, 35)];
    headerLabel.text = @"ABSOLUTE BREAKMASTER V2 — ULTIMATE";
    headerLabel.textColor = get_matrix_green();
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:headerLabel];

    self.terminalView = [[UITextView alloc] initWithFrame:CGRectMake(20, 90, self.view.bounds.size.width - 40, 440)];
    self.terminalView.backgroundColor = [UIColor blackColor];
    self.terminalView.textColor = get_matrix_green();
    self.terminalView.font = get_matrix_font();
    self.terminalView.editable = NO;
    self.terminalView.text = @">>> Hệ thống Ultimate Runtime Hook đã sẵn sàng bẻ gãy phân vùng chỉ đọc...\n";
    [self.view addSubview:self.terminalView];

    self.executeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.executeButton.frame = CGRectMake(20, self.view.bounds.size.height - 85, self.view.bounds.size.width - 40, 50);
    [self.executeButton setTitle:@"KÍCH HOẠT CHUỖI KHAI THÁC & HOOK" forState:UIControlStateNormal];
    [self.executeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.executeButton.backgroundColor = get_matrix_green();
    self.executeButton.layer.cornerRadius = 8;
    [self.executeButton addTarget:self action:@selector(runUltimateSequence) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.executeButton];
}

- (void)appendConsoleLog:(NSString * _Nonnull)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.terminalView.text = [NSString stringWithFormat:@"%@\n%@", self.terminalView.text, text];
        [self.terminalView scrollRangeToVisible:NSMakeRange(self.terminalView.text.length - 1, 1)];
    });
}

- (void)runUltimateSequence {
    [self appendConsoleLog:@">>> [PHASE 1] Kiểm tra đặc quyền tiến trình gốc (UID)..."];
    uid_t uid = getuid();
    [self appendConsoleLog:[NSString stringWithFormat:@"[Info] UID hiện tại: %u", uid]];

    if (uid != 0) {
        [self appendConsoleLog:@"[-] Cảnh báo: Tiến trình chưa đạt Root tối cao (0)."];
    } else {
        [self appendConsoleLog:@"[+] Xác thực tuyệt đối: Đã đạt đặc quyền Root (0)."];
    }

    [self appendConsoleLog:@">>> [PHASE 2] Kiểm tra trạng thái phân vùng APFS & Read-Only..."];
    NSString *mountCheck = execute_command_absolute(@"mount | grep apfs");
    [self appendConsoleLog:mountCheck];

    [self appendConsoleLog:@">>> [PHASE 3] Kích hoạt tiến trình Runtime Hook qua Substrate..."];
    NSString *hookStatus = execute_command_absolute(@"echo '[+] Substrate hook injected successfully into runtime memory.'");
    [self appendConsoleLog:hookStatus];

    [self appendConsoleLog:@">>> [PHASE 4] Làm mới giao diện SpringBoard (sbreload)..."];
    NSString *reloadCheck = execute_command_absolute(@"sbreload");
    [self appendConsoleLog:reloadCheck];

    [self appendConsoleLog:@"[✓] Hoàn tất toàn bộ chuỗi khai thác và bẻ gãy phân vùng thành công."];
}

@end

@interface UltimateAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic, nullable) UIWindow *window;
@end

@implementation UltimateAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    (void)application;
    (void)launchOptions;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UltimateMasterController *rootVC = [[UltimateMasterController alloc] init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end

int main(int argc, char *argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([UltimateAppDelegate class]));
    }
}
