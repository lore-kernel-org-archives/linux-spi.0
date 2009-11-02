From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/mpc52xx: check for invalid PSC usage
Date: Mon, 2 Nov 2009 11:03:24 -0700
Message-ID: <fa686aa40911021003r7c622654k654cd91d4ee58184@mail.gmail.com>
References: <1256297157-28246-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40910311822i4ba27b2bs350c5684cd57187b@mail.gmail.com>
	<20091102135244.GC4696@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20091102135244.GC4696@pengutronix.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Mon, Nov 2, 2009 at 6:53 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> I wouldn't even bother. =A0It's not actively dangerous to try and use
>> PSC{4,5} in SPI mode. =A0It just not going to work. =A0Besides, the
>> MPC5200 common code already checks for an invalid PSC number when
>> setting the clock divisor.
>>
>> Have you seen cases of users trying to do the wrong thing with the
>> crippled PSCs?
>
> Yes, that was the reason for this patch :) How about this patch to give u=
sers a
> better idea than just -ENODEV via set_psc_clkdiv? ...[/me hacks]...
> Uuuh, there is even a bug which makes the case go unnoticed.

Sure.  This looks okay to me.  I'll pick it up.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
