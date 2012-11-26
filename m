From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: Add Lattice ECP3 FPGA configuration via SPI
Date: Mon, 26 Nov 2012 17:54:47 +0530
Message-ID: <CAM=Q2cu6BHGzw4ZUesFugqnYX-6N-A7mFMZGAVH+VGH=5cS40g@mail.gmail.com>
References: <1353926520-4017-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1353926520-4017-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Nov 26, 2012 at 4:12 PM, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org> wrote:
> +
> +static int __devinit lattice_ecp3_probe(struct spi_device *spi)
> +{
> +       int err;
> +
> +       err = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
> +                                     FIRMWARE_NAME, &spi->dev,
> +                                     GFP_KERNEL, spi, firmware_load);
> +       if (err) {
> +               dev_err(&spi->dev, "Firmware loading failed with %d!\n", err);
> +               goto err;
nitpick:
the goto looks un-necessary, could we return err here and save an
un-necessary branch.

> +       }
> +
> +       dev_info(&spi->dev, "FPGA bitstream configuration driver registered (ver %s)\n",
> +               DRIVER_VER);
> +
> +       return 0;
> +
> +err:
> +       return err;
> +}

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
