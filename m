From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [RFC][PATCH v2 2/3] spi_bitbang : get nsecs delay from cs during transfer
Date: Tue, 14 Dec 2010 11:58:39 -0500
Message-ID: <AANLkTimdw5crEJTdnObURp_kxqjwFas2RuDMewd=CqEG@mail.gmail.com>
References: <1290205185-11956-1-git-send-email-bengardiner@nanometrics.ca>
	<cover.1291925752.git.bengardiner@nanometrics.ca>
	<67270e44ec792d1a684d6052f7aebbc8c538a6c1.1291925752.git.bengardiner@nanometrics.ca>
	<20101210114604.GB4228@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, Michael Buesch <mb@bu3sch.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101210114604.GB4228@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 10, 2010 at 6:46 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> Hi,
>
> thanks for the submission. It has some issues, though:

Hi Wolfram,

Thanks for the comments, I appreciate your interest in the RFC.

> On Thu, Dec 09, 2010 at 03:34:55PM -0500, Ben Gardiner wrote:
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 nsecs =3D
>> +#if defined(CONFIG_SLOWER_SPI_GPIO)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !cs->nsecs=
 ? cs->nsecs : 100;
>> +#else
>> + =A0 =A0 =A0 =A0 =A0 =A0 100;
>> +#endif
>
> This coding style is very hard to read and gains nothing for it. Also=
,
> slower_spi should rather be a per-device than a config option.

Yes, now that you mention it the implementation looks very clunky.

I think it is starting to sink-in that a 'slower' spi gpio _driver_ is
needed. I can think of a couple different ways to make the CS-to-data
delay assigned to 'nsecs' a per-device feature:
1) a flag or 2) a function pointer in struct spi_bitbang. Were you
thinking of something else entirely?

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
