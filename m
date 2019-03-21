From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: export tracepoint symbols to modules
Date: Thu, 21 Mar 2019 16:49:24 +0100
Message-ID: <20190321154924.e5naj2bpdxp7krjb@pengutronix.de>
References: <20190321124240.901884-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190321124240.901884-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 21, 2019 at 01:42:25PM +0100, Arnd Bergmann wrote:
> The newly added tracepoints in the spi-mxs driver cause a link
> error when the driver is a loadable module:
> 
> ERROR: "__tracepoint_spi_transfer_stop" [drivers/spi/spi-mxs.ko] undefined!
> ERROR: "__tracepoint_spi_transfer_start" [drivers/spi/spi-mxs.ko] undefined!
> 
> I'm not quite sure where to put the export statements, but
> directly after the inclusion of the header seems as good as
> any other place.

I agree it looks a bit ugly, but I don't have a better idea either.
> 
> Fixes: f3fdea3af405 ("spi: mxs: add tracing to custom .transfer_one_message callback")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks right:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for finding and fixing that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
