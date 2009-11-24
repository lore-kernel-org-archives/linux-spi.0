From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 20/38] move spidev_remove to .devexit.text
Date: Tue, 24 Nov 2009 16:22:33 -0500
Message-ID: <8bd0f97a0911241322g7816359u177aa35a36c24356@mail.gmail.com>
References: <1259096853-18909-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-20-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Ocker <weo@reccoware.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	spi-devel-general@lists.sourceforge.net,
	Alexey Dobriyan <adobriyan@gmail.com>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934053AbZKXVWt@vger.kernel.org>
In-Reply-To: <1259096853-18909-20-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2009/11/24 Uwe Kleine-K=C3=B6nig
> The function spidev_remove is used only wrapped by __devexit_p so def=
ine
> it using __devexit.

this doesnt go far enough to address actual section mismatch issues in
the driver.  i posted a more complete one here:
http://lkml.org/lkml/2009/10/13/76

and akpm has picked that up
-mike
