From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs integrated SPI
Date: Mon, 07 Jul 2014 09:08:41 +0200
Message-ID: <5578791.jcBVzrGadW@diego>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com> <20140704183249.GC14896@sirena.org.uk> <53B9FB1C.7080008@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: broonie@kernel.org, grant.likely@linaro.org, robh+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	olof@lixom.net, hj@rock-chips.com, kever.yang@rock-chips.com,
	xjq@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com,
	yzq@rock-chips.com, zhenfu.fang@rock-chips.com, cf@rock-chips.com,
	zhangqing@rock-chips.com, wei.luo@rock-chips.com,
	Mark Rutland <mark.rutland@arm.com>
To: addy ke <addy.ke@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53B9FB1C.7080008@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am Montag, 7. Juli 2014, 09:42:52 schrieb addy ke:
> > On Tue, Jul 01, 2014 at 09:03:59AM +0800, addy ke wrote:
> >> +static const struct of_device_id rockchip_spi_dt_match[] = {
> >> +	{ .compatible = "rockchip,rk3066-spi", },
> >> +	{ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
> > 
> > Your DT binding defined some additional compatible strings, please add
> > those to the driver.

citing Mark Rutland (one of the dt maintainers):

--
  That's why I said in addition to the common one. I'd only expect the
  driver to look for "rockchip,rk3066-spi", but a DTB could have:

        compatible = "rockchip,rk3188-spi", "rockchip,rk3066-spi";

  Seeding the DTBs with the extra strings early makes it more likely that
  we can rely on them later. If we don't happen to need them they only
  clutter some DTBs.
--

so it looks like the driver is doing the right thing right now


Heiko
