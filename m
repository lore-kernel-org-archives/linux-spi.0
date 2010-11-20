From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 6/6] atmel_spi: fix warning In function 'atmel_spi_dma_map_xfer'
Date: Sat, 20 Nov 2010 14:59:28 -0800 (PST)
Message-ID: <616676.83025.qm@web180301.mail.gq1.yahoo.com>
References: <20101120214820.GG8942@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101120214820.GG8942@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



--- On Sat, 11/20/10, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.d=
e> wrote:

> > +=A0=A0=A0 =A0=A0=A0 void
> *nonconst_tx =3D (void *)xfer->tx_buf; /* shut up gcc */

Reads like a bad patch to me. Fix the bug,
don't just silence GCC.  Or at least use
a better comment mentioning a constness
cast problems).

- Dave
