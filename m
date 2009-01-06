From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Date: Tue, 6 Jan 2009 09:26:34 +0100
Message-ID: <200901060926.34287.sr__31192.7634910264$1231230524$gmane$org@denx.de>
References: <1227628088-10849-1-git-send-email-sr@denx.de>
	<200901051912.25874.sr@denx.de>
	<20090105193117.E5AD98387CDB@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net
To: Wolfgang Denk <wd@denx.de>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20090105193117.E5AD98387CDB@gemini.denx.de>
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

Hi Wolfgang,

On Monday 05 January 2009, Wolfgang Denk wrote:
> > IIRC (I didn't write the original version of this driver) then this
> > comments simply refers to the fact that the platform can select a maximum
> > SPI frequency via spi->max_speed_hz which is pretty obvious. So I'll just
> > remove this comment in the next version.
>
> On PPC4xx systems we get one interrupt per transferred  byte,  i.  e.
> there  is  a  direct relation between SPI bus frequency and interrupt
> rate.
>
> Since this is a PPC4xx SPI driver, the comment is actually helpful to
> understand the operation of the driver especially in relation to  the
> limitations of the hardware.
>
> Instead of removing the  comment  (which  leaves  the  casual  reader
> clueless)  it  would probably better to add a sentence explaining the
> one byte / one interrupt situation?

OK, I'll this explanation instead.

Thanks.

Best regards,
Stefan
