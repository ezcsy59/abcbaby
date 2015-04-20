/*!
 @header IChatManagerGroup.h
 @abstract 为ChatManager提供群组的基础操作
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "IChatManagerBase.h"
#import "EMGroup.h"

/*!
 @protocol
 @brief 本协议包括：创建, 销毁, 加入, 退出等群组操作
 @discussion 所有不带Block回调的异步方法, 需要监听回调时, 需要先将要接受回调的对象注册到delegate中, 示例代码如下:
            [[[EaseMob sharedInstance] chatManager] addDelegate:self delegateQueue:dispatch_get_main_queue()]
 */
@protocol IChatManagerGroup <IChatManagerBase>

@required

#pragma mark - properties

/*!
 @property
 @brief 所加入和创建的群组列表, 群组对象
 */
@property (nonatomic, strong, readonly) NSArray *groupList;

#pragma mark - api

/*!
 @method
 @brief 创建一个私有群组
 @param subject        主题
 @param description    说明信息
 @param invitees       初始群组成员的用户名列表
 @param welcomeMessage 对初始群组成员的邀请信息
 @param pError         错误信息
 @result 创建的群组对象, 失败返回nil
 */
- (EMGroup *)createPrivateGroupWithSubject:(NSString *)subject
                               description:(NSString *)description
                                  invitees:(NSArray *)invitees
                     initialWelcomeMessage:(NSString *)welcomeMessage
                                     error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 创建一个私有群组
 @param subject        主题
 @param description    说明信息
 @param invitees       初始群组成员的用户名列表
 @param welcomeMessage 对初始群组成员的邀请信息
 @discussion
 函数执行完, 回调group:didJoinWithError:会被触发
 */
- (void)asyncCreatePrivateGroupWithSubject:(NSString *)subject
                               description:(NSString *)description
                                  invitees:(NSArray *)invitees
                     initialWelcomeMessage:(NSString *)welcomeMessage;

/*!
 @method
 @brief 异步方法, 创建一个私有群组
 @param subject        主题
 @param description    说明信息
 @param invitees       初始群组成员的用户名列表
 @param welcomeMessage 对初始群组成员的邀请信息
 @param completion     消息完成后的回调
 @param aQueue         回调block时的线程
 */
- (void)asyncCreatePrivateGroupWithSubject:(NSString *)subject
                               description:(NSString *)description
                                  invitees:(NSArray *)invitees
                     initialWelcomeMessage:(NSString *)welcomeMessage
                                completion:(void (^)(EMGroup *group,
                                                     EMError *error))completion
                                   onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 退出群组
 @param groupId  群组ID
 @param pError   错误信息
 @result 退出的群组对象, 失败返回nil
 */
- (EMGroup *)leaveGroup:(NSString *)groupId
                  error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 退出群组
 @param groupId  群组ID
 @discussion
 函数执行完, 回调group:didLeave:error:会被触发
 */
- (void)asyncLeaveGroup:(NSString *)groupId;

/*!
 @method
 @brief 异步方法, 退出群组
 @param groupId  群组ID
 @param completion 消息完成后的回调
 @param aQueue     回调block时的线程
 */
- (void)asyncLeaveGroup:(NSString *)groupId
             completion:(void (^)(EMGroup *group,
                                  EMGroupLeaveReason reason,
                                  EMError *error))completion
                onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 邀请用户加入群组
 @param occupants      被邀请的用户名列表
 @param groupId        群组ID
 @param welcomeMessage 欢迎信息
 @param pError         错误信息
 @result 返回群组对象, 失败返回空
 */
- (EMGroup *)addOccupants:(NSArray *)occupants
                  toGroup:(NSString *)groupId
           welcomeMessage:(NSString *)welcomeMessage
                    error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 邀请用户加入群组
 @param occupants      被邀请的用户名列表
 @param groupId        群组ID
 @param welcomeMessage 欢迎信息
 @discussion
        函数执行完, 回调group:didAddOccupants:welcomeMessage:error:会被触发
 */
- (void)asyncAddOccupants:(NSArray *)occupants
                  toGroup:(NSString *)groupId
           welcomeMessage:(NSString *)welcomeMessage;

/*!
 @method
 @brief 异步方法, 邀请用户加入群组
 @param occupants      被邀请的用户名列表
 @param groupId        群组ID
 @param welcomeMessage 欢迎信息
 @param completion     消息完成后的回调
 @param aQueue         回调block时的线程
 */
- (void)asyncAddOccupants:(NSArray *)occupants
                  toGroup:(NSString *)groupId
           welcomeMessage:(NSString *)welcomeMessage
               completion:(void (^)(NSArray *occupants,
                                    EMGroup *group,
                                    NSString *welcomeMessage,
                                    EMError *error))completion
                  onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 将某人请出群组
 @param occupant 要请出群组的人的用户名
 @param groupId  群组ID
 @param pError   错误信息
 @result 返回群组对象
 @discussion
        此操作需要admin/owner权限
 */
- (EMGroup *)removeOccupant:(NSString *)occupant
                  fromGroup:(NSString *)groupId
                      error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 将某人请出群组
 @param occupant 要请出群组的人的用户名
 @param groupId  群组ID
 @discussion
        此操作需要admin/owner权限.
        函数执行完, group:didRemoveOccupant:error:回调会被触发
 */
- (void)asyncRemoveOccupant:(NSString *)occupant
                  fromGroup:(NSString *)groupId;

/*!
 @method
 @brief 异步方法, 将某人请出群组
 @param occupant   要请出群组的人的用户名
 @param groupId    群组ID
 @param completion 消息完成后的回调
 @param aQueue     回调block时的线程
 @discussion
        此操作需要admin/owner权限
 */
- (void)asyncRemoveOccupant:(NSString *)occupant
                  fromGroup:(NSString *)groupId
                 completion:(void (^)(EMGroup *group,
                                      EMError *error))completion
                    onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 将某人加入群组黑名单
 @param occupant 要加入黑名单的用户名
 @param groupId  群组ID
 @param pError   错误信息
 @result 返回群组对象
 @discussion
        此操作需要admin/owner权限, 被加入黑名单的人, 不会再被允许进入群组
 */
- (EMGroup *)blockOccupant:(NSString *)occupant
                 fromGroup:(NSString *)groupId
                     error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 将某人加入群组黑名单
 @param occupant 要加入黑名单的用户名
 @param groupId  群组ID
 @discussion
        此操作需要admin/owner权限, 被加入黑名单的人, 不会再被允许进入群组
        函数执行完, group:didBlockOccupant:error:回调会被触发
 */
- (void)asyncBlockOccupant:(NSString *)occupant
                 fromGroup:(NSString *)groupId;

/*!
 @method
 @brief 异步方法, 将某人加入群组黑名单
 @param occupant   要加入黑名单的用户名
 @param groupId    群组ID
 @param completion 消息完成后的回调
 @param aQueue     回调block时的线程
 @discussion
        此操作需要admin/owner权限, 被加入黑名单的人, 不会再被允许进入群组
 */
- (void)asyncBlockOccupant:(NSString *)occupant
                 fromGroup:(NSString *)groupId
                completion:(void (^)(EMGroup *group,
                                     EMError *error))completion
                   onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 将某人从群组黑名单中解除
 @param occupant 要加入黑名单的用户名
 @param groupId  群组ID
 @param pError   错误信息
 @result 返回群组对象
 @discussion        
        此操作需要admin/owner权限, 从黑名单中移除后, 可以再次进入群组
        函数执行完, group:didUnblockOccupant:error:回调会被触发
 */
- (EMGroup *)unblockOccupant:(NSString *)occupant
                    forGroup:(NSString *)groupId
                       error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 将某人从群组黑名单中解除
 @param occupant 要加入黑名单的用户名
 @param groupId  群组ID
 @discussion
        此操作需要admin/owner权限, 从黑名单中移除后, 可以再次进入群组
        函数执行完, group:didUnblockOccupant:error:回调会被触发
 */
- (void)asyncUnblockOccupant:(NSString *)occupant
                    forGroup:(NSString *)groupId;

/*!
 @method
 @brief 异步方法, 将某人从群组黑名单中解除
 @param occupant   要加入黑名单的用户名
 @param groupId    群组ID
 @param completion 消息完成后的回调
 @param aQueue     回调block时的线程
 @discussion
        此操作需要admin/owner权限, 从黑名单中移除后, 可以再次进入群组
 */
- (void)asyncUnblockOccupant:(NSString *)occupant
                    forGroup:(NSString *)groupId
                  completion:(void (^)(EMGroup *group,
                                       EMError *error))completion
                     onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 更改群组主题
 @param subject  主题
 @param groupId  群组ID
 @param pError   错误信息
 @result 返回群组对象
 @discussion
        此操作需要admin/owner权限
 */
- (EMGroup *)changeGroupSubject:(NSString *)subject
                       forGroup:(NSString *)groupId
                          error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 更改群组主题
 @param subject  主题
 @param groupId  群组ID
 @discussion
        此操作需要admin/owner权限
        函数执行完, groupDidUpdateInfo:error:回调会被触发
 */
- (void)asyncChangeGroupSubject:(NSString *)subject
                       forGroup:(NSString *)groupId;

/*!
 @method
 @brief 异步方法, 更改群组主题
 @param subject    主题
 @param groupId    群组ID
 @param completion 消息完成后的回调
 @param aQueue     回调block时的线程
 @discussion
        此操作需要admin/owner权限
 */
- (void)asyncChangeGroupSubject:(NSString *)subject
                       forGroup:(NSString *)groupId
                     completion:(void (^)(EMGroup *group,
                                          EMError *error))completion
                        onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 更改群组说明信息
 @param newDescription 说明信息
 @param groupId        群组ID
 @param pError         错误信息
 @result 返回群组对象
 @discussion
        此操作需要admin/owner权限
 */
- (EMGroup *)changeDescription:(NSString *)newDescription
                      forGroup:(NSString *)groupId
                         error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 更改群组说明信息
 @param newDescription 说明信息
 @param groupId        群组ID
 @discussion
        此操作需要admin/owner权限.
        函数执行完, group:didChangeDescription:error:回调会被触发
 */
- (void)asyncChangeDescription:(NSString *)newDescription
                      forGroup:(NSString *)groupId;

/*!
 @method
 @brief 异步方法, 更改群组说明信息
 @param newDescription 说明信息
 @param groupId        群组ID
 @param completion     消息完成后的回调
 @param aQueue         回调block时的线程
 @discussion
        此操作需要admin/owner权限
 */
- (void)asyncChangeDescription:(NSString *)newDescription
                      forGroup:(NSString *)groupId
                    completion:(void (^)(EMGroup *group,
                                         EMError *error))completion
                       onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 更改成员的权限级别
 @param newAffiliation 新的级别
 @param occupant       被更改成员的用户名
 @param groupId        群组ID
 @param pError         错误信息
 @result 返回群组对象
 @discussion
        此操作需要admin/owner权限
 */
- (EMGroup *)changeAffiliation:(EMGroupMemberRole)newAffiliation
                   forOccupant:(NSString *)occupant
                       inGroup:(NSString *)groupId
                         error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 更改成员的权限级别
 @param newAffiliation 新的级别
 @param occupant       被更改成员的用户名
 @param groupId        群组ID
 @discussion
        此操作需要admin/owner权限.
        函数执行完, group:didChangeAffiliation:forOccupant:error:回调会被触发
 */
- (void)asyncChangeAffiliation:(EMGroupMemberRole)newAffiliation
                   forOccupant:(NSString *)occupant
                       inGroup:(NSString *)groupId;

/*!
 @method
 @brief 异步方法, 更改成员的权限级别
 @param newAffiliation 新的级别
 @param occupant       被更改成员的用户名
 @param groupId        群组ID
 @param completion     消息完成后的回调
 @param aQueue         回调block时的线程
 @discussion
        此操作需要admin/owner权限
 */
- (void)asyncChangeAffiliation:(EMGroupMemberRole)newAffiliation
                   forOccupant:(NSString *)occupant
                       inGroup:(NSString *)groupId
                    completion:(void (^)(EMGroup *group, EMError *error))completion
                       onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 接受并加入群组
 @param groupId 所接受的群组ID
 @param pError  错误信息
 @result 返回所加入的群组对象
 */
- (EMGroup *)acceptInvitationFromGroup:(NSString *)groupId
                                 error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 接受并加入群组
 @param groupId 所接受的群组ID
 @discussion
        函数执行后, didAcceptInvitationFromGroup:error:回调会被触发
 */
- (void)asyncAcceptInvitationFromGroup:(NSString *)groupId;

/*!
 @method
 @brief 异步方法, 接受并加入群组
 @param groupId    所接受的群组ID
 @param completion 消息完成后的回调
 @param aQueue     回调block时的线程
 */
- (void)asyncAcceptInvitationFromGroup:(NSString *)groupId
                            completion:(void (^)(EMGroup *group,
                                                 EMError *error))completion
                               onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 拒绝一个加入群组的邀请
 @param groupId  被拒绝的群组ID
 @param username 被拒绝的人
 @param reason   拒绝理由
 */
- (void)rejectInvitationForGroup:(NSString *)groupId
                       toInviter:(NSString *)username
                          reason:(NSString *)reason;

/*!
 @method
 @brief 获取群组信息
 @param groupId 群组ID
 @param pError  错误信息
 */
- (EMGroup *)fetchGroupInfo:(NSString *)groupId error:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 获取群组信息
 @param groupId 群组ID
 @discussion
        执行后, 回调didFetchGroupInfo:error:会被触发
 */
- (void)asyncFetchGroupInfo:(NSString *)groupId;

/*!
 @method
 @brief 异步方法, 获取群组信息
 @param groupId 群组ID
 @param completion 消息完成后的回调
 @param aQueue     回调block时的线程
 */
- (void)asyncFetchGroupInfo:(NSString *)groupId
                 completion:(void (^)(EMGroup *group,
                                      EMError *error))completion
                    onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @brief 获取所有与自己相关的群组列表
 @param pError 错误信息
 @result 群组对象列表
 */
- (NSArray *)fetchAllGroupsWithError:(EMError **)pError;

/*!
 @method
 @brief 异步方法, 获取所有与自己相关的群组列表
 @discussion
        执行后, 回调difFetchAllGroups:error:会被触发
 */
- (void)asyncFetchAllGroups;

/*!
 @method
 @brief 异步方法, 获取所有与自己相关的群组列表
 @param completion 消息完成后的回调
 @param aQueue     回调block时的线程
 */
- (void)asyncFetchAllGroupsWithCompletion:(void (^)(NSArray *groups,
                                                    EMError *error))completion
                                  onQueue:(dispatch_queue_t)aQueue;

@end
