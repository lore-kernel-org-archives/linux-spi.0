From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/5] spi-imx: some updates
Date: Tue, 8 Dec 2009 17:25:59 -0700
Message-ID: <fa686aa40912081625y3750a7fegbac38926182e38c6@mail.gmail.com>
References: <20091208211258.GA13706@pengutronix.de> <20091208153239.af0b5bb8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Mack <daniel@caiaq.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966973AbZLIA0P@vger.kernel.org>
In-Reply-To: <20091208153239.af0b5bb8.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2009/12/8 Andrew Morton <akpm@linux-foundation.org>:
> On Tue, 8 Dec 2009 22:12:58 +0100
> Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:
>
>> this series depends on "spi: drain MXC SPI transfer buffer when prob=
ing
>> device" which is currently in -mm and also included in my spi-imx br=
anch
>> (see below). =A0IMHO at least my first patch should go into .33 as i=
t
>> fixes an oops.
>
> I queued all five for 2.6.33.

I had also picked up "drain MXC SPI transfer..." into my next-spi tree
earlier today.  After a few days I'll send Linus a pull request.  I
just need to make sure that Ben's tree gets pulled first because I've
got other stuff in there depending on it.

> Once I've merged up the current -mm patch queue:
[... list of patches snipped ...]
> I shall stop sending SPI patches to Linus. =A0I'll send any which I
> accumulate to Grant instead.

I'm new to the job, so I'm being cautions about which things I'm pick
up.  However, I'll happily merge anything that Andrew says is okay.
Andrew, when in the merge window do you typically send out patch
queues?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
