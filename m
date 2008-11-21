From: Stefan Roese <sr@denx.de>
Subject: Re: [spi-devel-general] [PATCH v4] spi: Add PPC4xx SPI driver
Date: Fri, 21 Nov 2008 19:01:45 +0100
Message-ID: <200811211901.45371.sr@denx.de>
References: <1225451266-23740-1-git-send-email-sr@denx.de>
	<200811201941.08468.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
To: David Brownell <david-b@pacbell.net>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200811201941.08468.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
List-Id: linux-spi.vger.kernel.org

Dave,

On Friday 21 November 2008, David Brownell wrote:
> On Friday 31 October 2008, Stefan Roese wrote:
> > +=A0=A0=A0=A0=A0=A0=A0dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__FUNCTION__, spi->mode, =
spi->bits_per_word,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spi->max_speed_hz);
>
> Oh, and checkpatch.pl would warn about __FUNCTION__ vs __func__ ...

Thanks for the review. I'll address the issues in an updated patch next wee=
k.

Best regards,
Stefan
