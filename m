From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [RFC][PATCH v2 2/3] spi_bitbang : get nsecs delay from cs during transfer
Date: Tue, 14 Dec 2010 13:17:22 -0500
Message-ID: <AANLkTi=Fi+TaV=FJfz07kGBLnKMDoh5ph2vnLA9xLNVK@mail.gmail.com>
References: <1290205185-11956-1-git-send-email-bengardiner@nanometrics.ca>
	<cover.1291925752.git.bengardiner@nanometrics.ca>
	<67270e44ec792d1a684d6052f7aebbc8c538a6c1.1291925752.git.bengardiner@nanometrics.ca>
	<20101210114604.GB4228@pengutronix.de>
	<AANLkTimdw5crEJTdnObURp_kxqjwFas2RuDMewd=CqEG@mail.gmail.com>
	<20101214180840.GB4584@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, Michael Buesch <mb@bu3sch.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101214180840.GB4584@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 14, 2010 at 1:08 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi Ben,
>
>> I think it is starting to sink-in that a 'slower' spi gpio _driver_ is
>> needed. I can think of a couple different ways to make the CS-to-data
>> delay assigned to 'nsecs' a per-device feature:
>> 1) a flag or 2) a function pointer in struct spi_bitbang. Were you
>> thinking of something else entirely?
>
> Nope, just saw (very high-level) that it should be per-device as it
> might be feasible to have a fast and a slow bus at the same time. My
> advice would be to start coding your favourite solution and check if it
> feels right :)

:) Sounds like good advice.

Thanks again, Wolfram.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
