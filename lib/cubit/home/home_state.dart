part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Result<ProfileRes>? profileUpdateReq;
  final Result<List<GetJobRes>>? getJobAllReq;
  final Result<List<GetJobRes>>? getJobRecent;
  const HomeState({
    this.profileUpdateReq,
    this.getJobAllReq,
    this.getJobRecent,
  });

  @override
  List<Object?> get props => [profileUpdateReq, getJobAllReq, getJobRecent];

  HomeState copyWith({
    Result<ProfileRes>? profileUpdateReq,
    Result<List<GetJobRes>>? getJobAllReq,
    Result<List<GetJobRes>>? getJobRecent,
  }) {
    return HomeState(
      profileUpdateReq: profileUpdateReq ?? this.profileUpdateReq,
      getJobAllReq: getJobAllReq ?? this.getJobAllReq,
      getJobRecent: getJobRecent ?? this.getJobRecent,
    );
  }
}
