From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] spi: psdev: add passive serial driver
Date: Thu, 13 Mar 2014 17:14:50 +0000
Message-ID: <20140313171450.GA25870@e106331-lin.cambridge.arm.com>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "broonie@kernel.org" <broonie@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 12, 2014 at 03:53:37PM +0000, Michael Grzeschik wrote:
> This patch introduces the psdev driver. It is used to communicate to an
> Altera passive serial connected FPGA by writing into an character
> device.
> 
> It simply initates the protocol on open and clocks the data into the
> FPGA by using the underlying SPI bus on write. The used SPI bus can also
> be an bitbang SPI bus. On close it will check for the response of the
> FPGA and tells if the write process was successful.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/spi/Kconfig    |   9 +
>  drivers/spi/Makefile   |   1 +
>  drivers/spi/spipsdev.c | 520 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 530 insertions(+)
>  create mode 100644 drivers/spi/spipsdev.c

[...]

> +static const struct of_device_id psdev_dt_ids[] = {
> +       { .compatible = "altr,passive-serial" },
> +       {},
> +};

There should be a binding document for this as part of the series.

Thanks,
Mark.
