From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/7] Updates for spi-imx
Date: Wed, 30 Sep 2009 16:52:41 -0700
Message-ID: <20090930165241.ecb2a83e.akpm@linux-foundation.org>
References: <20090930194211.GB1881@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, s.hauer@pengutronix.de,
	g.liakhovetski@gmx.de, linux-kernel@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755049AbZI3XxW@vger.kernel.org>
In-Reply-To: <20090930194211.GB1881@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 30 Sep 2009 21:42:11 +0200
Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:

> as a followup to this mail I'll send some updates for the spi-imx
> driver for review.

Several of these patches were unchangelogged but afaict they all fix
bugs and hence should be in 2.6.32, yes?

Renaming the entire source file after -rc1 was probably a bit naughty,
but we'll survive.
