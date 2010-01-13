From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RESEND PATCH 5/5] spi/mpc8xxx: don't check platform_get_irq's
 return value against zero
Date: Wed, 13 Jan 2010 14:17:03 +0300
Message-ID: <20100113111702.GA5004@oksana.dev.rtsoft.ru>
References: <1260979809-24811-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1263380746-27803-5-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, David Vrabel <dvrabel@arcom.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	Kumar Gala <galak@kernel.crashing.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	spi-devel-general@lists.sourceforge.net
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755928Ab0AMLRJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1263380746-27803-5-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 13, 2010 at 12:05:46PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> platform_get_irq returns -ENXIO on failure, so !irq was probably
> always true.  Make irq a signed variable and compare irq <=3D 0.  Not=
e
> that a return value of zero is still handled as error even though thi=
s
> could mean irq0.
>=20
> This is a followup to 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 that
> changed the return value of platform_get_irq from 0 to -ENXIO on erro=
r.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: David Vrabel <dvrabel@arcom.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: spi-devel-general@lists.sourceforge.net
> ---

Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Thanks!
