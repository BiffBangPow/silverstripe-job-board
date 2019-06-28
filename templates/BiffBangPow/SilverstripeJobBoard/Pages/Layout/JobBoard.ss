<div class="job-board">

    <div class="container">
        <div class="row">

            <div class="col-12">
                <h1 class="text-uppercase job-board__header-search pr-4">
                    <span class="font-weight-bold">Search results</span> <% if $CurrentTitleSearch %>$CurrentTitleSearch<% else %>for all jobs<% end_if %>
                </h1>
                <p class="job-board__header-results"><strong>Jobs</strong> $Results.FirstItem - $Results.LastItem <strong>of</strong> $Results.TotalItems</p>
            </div>

            <div class="col-12 col-lg-3">

                <div class="panel job-board-filters mb-xs-5 mb-sm-5">

                    <form name="job-search" method="get">

                        <div class="job-board-filters__header">
                            <a href="$Link" class="btn btn-outline-primary px-3 py-1 my-auto" id="job-search-reset">reset</a>
                        </div>


                        <div class="job-board__job-search">

                            <div>
                                <input id="job-search-title" class="job-search-title my-2 my-xl-3" type="text" name="t" value="$CurrentTitleSearch" placeholder="search keywords" />
                            </div>

                            <div>
                                <h4>Sectors</h4>
                                <% loop $JobSectors %>
                                    <div class="form-check">
                                        <input
                                            type="checkbox"
                                            id="sector$ID"
                                            name="s[]"
                                            value="$ID"
                                            class="form-check-input"
                                            <% if $Top.IsSelectedSector($ID) %>checked<% end_if %>
                                        />
                                        <label class="form-check-label" for="sector$ID">$Title</label>
                                    </div>
                                <% end_loop %>
                            </div>

                            <div>
                                <h4>Locations</h4>
                                <% loop $JobLocations %>
                                <div class="form-check">
                                    <input
                                        class="form-check-input"
                                        type="radio"
                                        id="job-search-location"
                                        name="l"
                                        value="$ID"
                                        <% if $Top.IsSelectedLocation($ID) %>checked<% end_if %>
                                    />
                                    <label class="form-check-label" for="location$ID">$Title</label><br />
                                </div>
                                <% end_loop %>
                            </div>

                        </div>

                        <div>
                            <button id="job-search-filter-btn" type="submit" class="job-search-filter-btn btn btn-primary py-2 px-4 mb-3">
                                Filter
                            </button>
                        </div>
                    </form>

                </div>

            </div>

            <div class="col-12 col-lg-9">
                <% loop $Results %>
                    <div class="job-board__posting mb-3">
                        <div class="row no-gutters">
                            <div class="col-lg-7">
                                <div class="job-board__posting-title d-flex px-4 px-lg-6 pt-4 pb-2 col-12">
                                    <a href="$Link" class="text-dark"><div class="job-title-enhance" data-job-id="$ID">$Title</div></a>
                                </div>
                                <div class="job-summary px-4 px-lg-6 pt-2 pb-4">
                                    <p>$Excerpt</p>
                                </div>
                            </div>
                            <div class="col-lg-5 d-flex flex-column">
                                <div class="details h-100 d-flex flex-column p-4">

                                    <p class="mb-2 detail"><i class="text-primary fal mr-1 fa-fw fa-thumbtack"></i> $DisplayLocation</p>
                                    <p class="mb-3 detail"><i class="text-primary fal mr-1 fa-fw fa-money-bill"></i> $Salary</p>
                                    <a href="$Link" class="font-weight-bold text-primary view-job-link">VIEW JOB <i class="far fa-chevron-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% end_loop %>
            </div>

        </div>

        <div class="col-12">
            <nav class="pagination-nav">

                <% if $Results.MoreThanOnePage %>
                    <ul class="pagination justify-content-center">
                        <% if $Results.NotFirstPage %>
                            <li class="page-item"><a class="page-link" href="$Results.PrevLink">&lt;</a></li>
                        <% else %>
                            <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                        <% end_if %>
                        <% loop $Results.PaginationSummary(4) %>
                            <% if $CurrentBool %>
                                <li class="page-item active"><a class="page-link" href="#">$PageNum</a></li>
                            <% else %>
                                <% if $Link %>
                                    <li class="page-item"><a class="page-link" href="$Link">$PageNum</a></li>
                                <% else %>
                                    <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">...</a></li>
                                <% end_if %>
                            <% end_if %>
                        <% end_loop %>
                        <% if $Results.NotLastPage %>
                            <li class="page-item"><a class="page-link" href="$Results.NextLink">&gt;</a></li>
                        <% else %>
                            <li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                        <% end_if %>
                    </ul>
                <% end_if %>
            </nav>
        </div>

    </div>

</div>

<% if $Content %>
    <div class="container">
        $Content
    </div>
<% end_if %>

$ElementalArea
$Form
$CommentsForm
