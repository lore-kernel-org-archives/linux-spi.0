From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 09/28] drivers: Add generic match helper by
 ACPI_COMPANION device
Date: Tue, 18 Jun 2019 10:40:47 +0200
Message-ID: <CAJZ5v0io59U1yy4RnX0fSXFyQ-PSHb1wXjLp7XLi8SzO3hSdVA@mail.gmail.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-10-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0gi2vpr5y3USnPnPBHjPA1YAwfqjsJppfLgBP5CcycGog@mail.gmail.com> <85f942fc-52fd-c4ed-29b3-f28c55a6a7bb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85f942fc-52fd-c4ed-29b3-f28c55a6a7bb@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 18, 2019 at 10:38 AM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> Hi Rafael,
>
> On 17/06/2019 23:07, Rafael J. Wysocki wrote:
> > On Fri, Jun 14, 2019 at 7:55 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> Add a generic helper to match a device by the ACPI_COMPANION device.
> >> This will be later used for providing wrappers for
> >> (bus/class/driver)_find_device().
> >>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: linux-acpi@vger.kernel.org
> >> Cc: linux-spi@vger.kernel.org
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> > Please fold this change into the patch adding users of device_match_acpi_dev().
>
> There are variants of this by class/bus/driver and all of them are introduced
> as separate patches with the respective users. If we do for this, we have to
> do the same for other matches as well.
>
> i.e, [ device_match_by_attr + class_find_device_by_attr & users +
> driver_find_device_by_attr & users + bus_find_device_by_attr & users ]
>
> And that becomes a large chunk, which could make the review painful.
>
> If you would still like that approach, I could do that in the next revision.

Yes, please.
