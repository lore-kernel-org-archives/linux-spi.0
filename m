From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: add statistics gathering and reporting methods
Date: Mon, 4 May 2015 17:50:11 +0200
Message-ID: <812CF966-8B7D-4019-810D-BF2B17D86A67@martin.sperl.org>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org> <1430741564-2849-2-git-send-email-kernel@martin.sperl.org> <20150504134226.GY15510@sirena.org.uk> <9A0ADDBC-5D5A-428F-B434-9CCB97505DCB@martin.sperl.org> <20150504143030.GE15510@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150504143030.GE15510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 04.05.2015, at 16:30, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> I'm not saying don't lock, I'm asking if adding this spinlock is the
> best way of doing this.  We already lock the master most of the time,
> can we not continue using the same lock?

Tell me the lock to use and I am happy to handle it.
but a quick look shows that transfer_one_message is running without
a lock held=E2=80=A6

We could hold a lock while we run in spi_transfer_one_message
but that could mean that gathering statistics could get blocked
for long periods of time - thta is why I had used a separate lock
that is only held during the =E2=80=9Cbulk=E2=80=9D update=E2=80=A6

But for that to work we will need to allocate spi_master_class
(among other things) dynamically - Let us see how that works.--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
