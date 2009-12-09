From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [spi-devel-general] [PATCH 0/5] spi-imx: some updates
Date: Wed, 9 Dec 2009 09:47:17 +0900
Message-ID: <1b68c6790912081647p39f0b285q2c164ab41c673aeb@mail.gmail.com>
References: <20091208211258.GA13706@pengutronix.de>
	 <20091208153239.af0b5bb8.akpm@linux-foundation.org>
	 <fa686aa40912081625y3750a7fegbac38926182e38c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, Daniel Mack <daniel@caiaq.de>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S967031AbZLIArN@vger.kernel.org>
In-Reply-To: <fa686aa40912081625y3750a7fegbac38926182e38c6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 9, 2009 at 9:25 AM, Grant Likely <grant.likely@secretlab.ca=
> wrote:
> 2009/12/8 Andrew Morton <akpm@linux-foundation.org>:
>> On Tue, 8 Dec 2009 22:12:58 +0100
>> Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:
>>
>>> this series depends on "spi: drain MXC SPI transfer buffer when pro=
bing
>>> device" which is currently in -mm and also included in my spi-imx b=
ranch
>>> (see below). =C2=A0IMHO at least my first patch should go into .33 =
as it
>>> fixes an oops.
>>
>> I queued all five for 2.6.33.
>
> I had also picked up "drain MXC SPI transfer..." into my next-spi tre=
e
> earlier today. =C2=A0After a few days I'll send Linus a pull request.=
 =C2=A0I
> just need to make sure that Ben's tree gets pulled first because I've
> got other stuff in there depending on it.
>
>> Once I've merged up the current -mm patch queue:
> [... list of patches snipped ...]
>> I shall stop sending SPI patches to Linus. =C2=A0I'll send any which=
 I
>> accumulate to Grant instead.
>
> I'm new to the job, so I'm being cautions about which things I'm pick
> up. =C2=A0However, I'll happily merge anything that Andrew says is ok=
ay.
> Andrew, when in the merge window do you typically send out patch
> queues?
>

Grant, may I know of your tree, if it's public?
thanks
