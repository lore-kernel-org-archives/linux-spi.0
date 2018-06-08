From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Fri, 8 Jun 2018 16:34:43 -0700
Message-ID: <20180608233443.GF88063@google.com>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, sdharia@codeaurora.org,
        kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        amstan@chromium.org
To: Girish Mahadevan <girishm@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 03, 2018 at 03:34:43PM -0600, Girish Mahadevan wrote:
> This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
> Qualcomm Generic Interface (GENI) is a programmable module supporting a
> wide range of serial interfaces including SPI. This driver supports SPI
> operations using FIFO mode of transfer.
> 
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  drivers/spi/Kconfig               |  12 +
>  drivers/spi/Makefile              |   1 +
>  drivers/spi/spi-geni-qcom.c       | 766 ++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi-geni-qcom.h |  14 +
>  4 files changed, 793 insertions(+)
>  create mode 100644 drivers/spi/spi-geni-qcom.c
>  create mode 100644 include/linux/spi/spi-geni-qcom.h
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> new file mode 100644
> index 0000000..eecc634
> --- /dev/null
> +++ b/drivers/spi/spi-geni-qcom.c
>
> ...
>
> +static irqreturn_t geni_spi_isr(int irq, void *dev)
> +{
> +	struct spi_geni_master *mas = dev;
> +	struct geni_se *se = &mas->se;
> +	u32 m_irq = 0;
> +	irqreturn_t ret = IRQ_HANDLED;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mas->lock, flags);
> +	if (pm_runtime_status_suspended(dev)) {

kasan is unhappy about geni_spi_isr:

[    3.206593] BUG: KASAN: slab-out-of-bounds in geni_spi_isr+0x978/0xbf4
[    3.213310] Read of size 4 at addr ffffffc0da803b04 by task swapper/0/1
[    3.221664] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.47 #20
[    3.227936] Hardware name: Google Cheza (DT)
[    3.232341] Call trace:
[    3.234884] [<ffffff90080925a4>] dump_backtrace+0x0/0x6d0
[    3.240441] [<ffffff9008092cc8>] show_stack+0x20/0x2c
[    3.245649] [<ffffff90094b53f8>] __dump_stack+0x20/0x28
[    3.251034] [<ffffff90094b53b0>] dump_stack+0xcc/0xf4
[    3.256240] [<ffffff90083cfb58>] print_address_description+0x70/0x238
[    3.262868] [<ffffff90083d00ec>] kasan_report+0x1cc/0x260
[    3.268425] [<ffffff90083d021c>] __asan_report_load4_noabort+0x2c/0x38
[    3.275142] [<ffffff9008ca820c>] geni_spi_isr+0x978/0xbf4
...
[    3.662568] Allocated by task 1:
[    3.665908]  kasan_kmalloc+0xb4/0x174
[    3.669693]  __kmalloc+0x260/0x2f4
[    3.673201]  __spi_alloc_controller+0x38/0x180
[    3.677781]  spi_geni_probe+0x38/0x574
[    3.681647]  platform_drv_probe+0xac/0x134
[    3.685865]  driver_probe_device+0x470/0x4f4
[    3.690268]  __driver_attach+0xe8/0x128
[    3.694228]  bus_for_each_dev+0x104/0x16c
[    3.698356]  driver_attach+0x48/0x54
[    3.702052]  bus_add_driver+0x258/0x3d0
[    3.706010]  driver_register+0x1ac/0x230
[    3.710056]  __platform_driver_register+0xcc/0xdc
[    3.714906]  spi_geni_driver_init+0x1c/0x24
[    3.719220]  do_one_initcall+0x22c/0x3c4
[    3.723266]  kernel_init_freeable+0x31c/0x40c
[    3.727753]  kernel_init+0x14/0x10c
[    3.731349]  ret_from_fork+0x10/0x18

Reason is that 'dev' is passed to pm_runtime_status_suspended(), when
it should be 'mas->dev'.

As this bug indicates kernel developers have strong expectations what
a variable called 'dev' represents, I suggest to change it to
something like 'data'.

Thanks

Matthias
