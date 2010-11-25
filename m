From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after off-mode transition
Date: Wed, 24 Nov 2010 19:55:25 -0800 (PST)
Message-ID: <249691.92718.qm@web180302.mail.gq1.yahoo.com>
References: <87y68i447o.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-omap <linux-omap@vger.kernel.org>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Kevin Hilman <khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <87y68i447o.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



--- On Wed, 11/24/10, Kevin Hilman <khilman@deeprootsystems.com> wrote:

>  I'm not SPI-aware enough to ack
> this patch or
> test it thoroughly.

Heh, my excuse is usually "not enough time"
or sometimes "no test setup" ... ;)

In this case I can at least ack the fix in
principle.  CS active means an active trransfer,
which must not happen during OFF  or other
suspend states.


Acked-by: David Brownell <dbrownell@users.sourceforge.net>



> Also, in the last patch I suggested you do more of a
> save/restore of
> this value instead of a restore to a hard-coded
> value.=A0 IOW, save the
> value in the suspend method, restore it in resume.


More correct to restart
message queue processing
after resume, if it's non-empty, and to have
cleanly stopped it (between messages) before
entering suspend states like OFF.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
