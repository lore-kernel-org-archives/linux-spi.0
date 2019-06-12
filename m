From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 07/13] drivers: Add generic match helper by ACPI_COMPANION device
Date: Thu, 13 Jun 2019 00:07:34 +0200
Message-ID: <12403040.8iQv1AJh6Y@kreacher>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com> <CAJZ5v0i0WP88+vTEheSTfAoSi5nEdjaLs4KOGxXK3_AoPhPrhg@mail.gmail.com> <621f33db-d7d8-380e-fe50-effb27523068@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <621f33db-d7d8-380e-fe50-effb27523068@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, June 12, 2019 11:43:38 AM CEST Suzuki K Poulose wrote:
> Hi Rafael,
> 
> On 06/06/2019 10:57, Rafael J. Wysocki wrote:
> > On Thu, Jun 6, 2019 at 11:28 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >>
> >>
> >> On 06/06/2019 10:17, Rafael J. Wysocki wrote:
> >>> On Wed, Jun 5, 2019 at 5:14 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>>>
> >>>> Add a generic helper to match a device by the acpi device.
> >>>
> >>> "by its ACPI companion device object", please.
> >>
> >> Sure.
> >>
> >>>
> >>> Also, it would be good to combine this patch with the patch(es) that
> >>> cause device_match_acpi_dev() to be actually used.
> >>>
> >>> Helpers without any users are arguably not useful.
> >>
> >> Sure, the helpers will be part of the part2 of the whole series,
> >> which will actually have the individual subsystems consuming the
> >> new helpers. For your reference, it is available here :
> >>
> >> http://linux-arm.org/git?p=linux-skp.git;a=shortlog;h=refs/heads/driver-cleanup/v2
> >>
> >> e.g:
> >> http://linux-arm.org/git?p=linux-skp.git;a=commit;h=59534e843e2f214f1f29659993f6e423bef16b28
> >>
> >> I could simply pull those patches into this part, if you prefer that.
> > 
> > Not really.
> > 
> > I'd rather do it the other way around: push the introduction of the
> > helpers to part 2.
> 
> Sure, I will do that.
> 
> > 
> >> However, that would be true for the other patches in the part2.
> >> I am open to suggestions, on how to split the series.
> > 
> > You can introduce each helper along with its users in one patch.
> > 
> > This way the total number of patches will be reduced and they will be
> > easier to review IMO.
> > 
> 
> Wouldn't it make the merging complicated ? I am still not clear how we plan
> to merge the part 2 ?

I wouldn't worry about it that much.  Without review, you have nothing to merge anyway.

Technically, every patch with a new helper and its users can go in via the Greg's tree
as long as it has been ACKed by the maintainers of the code touched by it.
