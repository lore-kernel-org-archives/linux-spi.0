From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/7] spi/mpc8xxx: don't check platform_get_irq's return
 value against zero
Date: Wed, 16 Dec 2009 19:32:29 +0300
Message-ID: <20091216163229.GA26350@oksana.dev.rtsoft.ru>
References: <1260979809-24811-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de>
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
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935059AbZLPQjP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1260979809-24811-6-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 16, 2009 at 05:10:08PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> platform_get_irq returns -ENXIO on failure, so !irq was probably
> always true.  Better use (int)irq <=3D 0.  Note that a return value o=
f
> zero is still handled as error even though this could mean irq0.
>=20
> This is a followup to 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 that
> changed the return value of platform_get_irq from 0 to -ENXIO on erro=
r.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Noooooo... :-(

Please revert 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 instead,
and fix platforms to remap HWIRQ0 to something that is not VIRQ0.

IRQ0 is invalid for everything that is outside of arch/*.

http://lkml.org/lkml/2005/11/22/159
http://lkml.org/lkml/2005/11/22/213
http://lkml.org/lkml/2005/11/22/227

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
