//
//  ISSTEmploymentViewController.m
//  ISST
//
//  Created by liuyang on 14-4-15.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "ISSTRecommendViewController.h"
#import "ISSTRecommendTableViewCell.h"
#import "ISSTPushedViewController.h"
#import "ISSTJobsApi.h"
#import "ISSTJobsModel.h"
@interface ISSTRecommendViewController ()
@property (weak, nonatomic) IBOutlet UITableView *recommendTableView;
@property (nonatomic,strong)ISSTJobsApi  *recommendApi;
@property (nonatomic,strong)ISSTJobsModel  *recommendModel;
@property (strong, nonatomic)NSMutableArray *recommendArray;
//@property (nonatomic,strong) ISSTExperienceDetailViewController *detailView;
@end

@implementation ISSTRecommendViewController
@synthesize recommendApi;
@synthesize recommendArray;
@synthesize recommendModel;
@synthesize recommendTableView;
static NSString *CellTableIdentifier=@"ISSTRecommendTableViewCell";


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view.backgroundColor = [UIColor lightGrayColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [super viewDidLoad];
    self.recommendApi = [[ISSTJobsApi alloc]init];
    
    self.recommendApi.webApiDelegate=self;
    // self.newsArray =[[NSMutableArray alloc]init];
    //UITableView *tableView=(id)[self.view viewWithTag:99];
    recommendTableView.rowHeight=90;
    UINib *nib=[UINib nibWithNibName:@"ISSTRecommendTableViewCell" bundle:nil];
    [recommendTableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.recommendApi requestRecommendLists:1 andPageSize:20 andKeywords:@"string"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return recommendArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    recommendModel =[[ISSTJobsModel alloc]init];
    recommendModel = [recommendArray objectAtIndex:indexPath.row];
    
    ISSTRecommendTableViewCell *cell=(ISSTRecommendTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        cell = (ISSTRecommendTableViewCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
    }
    
    cell.title.text=recommendModel.title;
    cell.time.text=recommendModel.updatedAt;
    cell.content.text=recommendModel.description;
    return cell;
}
#pragma mark - Table view delegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.detailView=[[ISSTExperienceDetailViewController alloc]initWithNibName:@"ISSTExperienceDetailViewController" bundle:nil];
//    self.detailView.navigationItem.title =@"详细信息";
//    ISSTCampusNewsModel *tempNewsModel=[[ISSTCampusNewsModel alloc]init];
//    tempNewsModel= [experenceArray objectAtIndex:indexPath.row];
//    self.detailView.experienceId=tempNewsModel.newsId;
//    // [self.navigationController setNavigationBarHidden:YES];    //set system navigationbar hidden
//    [self.navigationController pushViewController:self.detailView animated: NO];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

#pragma mark -
#pragma mark  ISSTWebApiDelegate Methods
- (void)requestDataOnSuccess:(id)backToControllerData
{
    if ([recommendArray count]) {
        recommendArray = [[NSMutableArray alloc]init];
    }
    recommendArray = (NSMutableArray *)backToControllerData;
    //  NSLog(@"count =%d ,newsArray = %@",[ExperenceArray count],ExperenceArray);
    [recommendTableView reloadData];
}

- (void)requestDataOnFail:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您好:" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Private Methods
- (void)pushViewController {
    NSString *vcTitle = [self.title stringByAppendingString:@" - Pushed"];
    UIViewController *vc = [[ISSTPushedViewController alloc] initWithTitle:vcTitle];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
