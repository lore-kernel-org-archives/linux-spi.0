Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795859952;
	b=mehb9IP9gxO+YEiOJ8bVuixMlsxeQ+veYv1EoAKtJRVW3mKsYLILtwLXeoax/ZnHCJ34
	 soSd8l8ftfu1fx8B8WrAIu/IfZdYDIw53JNYh2VeDPQYMmPL5UBE3p5Pnf6bnazzTtx0C
	 S827L3n5afDEfI504P88ZHNOoeKqop9V2JfRR1OmQv5gHluxXMQC3iXZur2mx98Kz5cNW
	 xuz239B1aKHaaowLYZUd21gvzg/fZFzJkuOOTH8bObmrzEHfZuG/b5BEKeboWnENE9Xxz
	 Csn/q5v7IuzucCzJlTwxet7Ps+xd/VNDeHTi4jyRZlApT4yc5CdY6UlxX7+Cuk9fyJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859952;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:
	 CFBL-Address:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ocwDXLOd2EJibowVHGqo+WQcUtYKeJ8W34XFSCoxilM=;
	b=V/ylTZub2szPx90/b7Dc6HklQTOL/1WYB+ksQ6bAIMKmdmFV+TDkyr6WC2FHZln+ebWv
	 7NMbV0fF48kPnSGfX+wXfvPsSpqX5yTxLPTdZKjNhr4YTvvGnYhV2lSnUgtEm07Kb+DS2
	 Qax2Zvlmd9X46GpW5L3f6P3v0CcxNgPTo020jKBi+7IDWUqFmwKXpUBdZd6E62kTumjyv
	 Hs/qy/+4MGJkXFi0Vs6D+NAGJ4DJ9Ao0PFtgGp2mcg9gD9L/CRblPG9gLf0dAV81IXWaC
	 5cSyBgngKFWdsrm/E335QcZ+6s2MkckCfCRaI6vnqXlgOIMxK6e3jiV+CkVAjrVAeTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kwiboo.se;
	spf=pass smtp.mailfrom=fe-bounces.kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=zBTOyEK8;
	dkim=pass header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=kxive7Uu;
	arc=none smtp.remote-ip=121.127.44.73
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF6606A321
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 09:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30DF6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=zBTOyEK8;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=kxive7Uu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1795859944; bh=ocwDXLOd2EJibowVHGqo+WQcUtYKeJ8W34XFSCoxilM=;
 b=zBTOyEK87DJrGhBV2oS6HjFyXFvC+qcaRlH921MrxdseERlBWZ8vrkOwyt98Gmsl+AYILh4bg
 Rx3FJwE1DTNcnP53E3wzYXm6ulS3c5GkiskWudk7gASNk/fa3CIPolQ0q4vW3eZe/qwgCEkWQI4
 opGlSCkmksedZplsWkurOKVtoaTbuD3Hg1s6zOWXY7YobJQefSDbDlG+dD/nbsaJxJOAb/Qhfqe
 rt8t+jMqlWj1tsOI+NvfEpauL8CE7BbKDhPV0aLL4tgtWqSywa7Scu0kS07ZwUGUlb4pnaMUL5A
 Py3LZu+zmVNdz0a9Ia7JGkPV+mlk1B0BGHMd+JZEfDtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1795859944; bh=ocwDXLOd2EJibowVHGqo+WQcUtYKeJ8W34XFSCoxilM=;
 b=kxive7UunxTe/FtPLcpO3DR7fbzRsTHtviCY4Aw5mgaL/22ZjEAiIOey0gt2/Nm6/1sIc+7Yq
 eWaAVsdkEhOoF7tgj4VwnGHL0cfneVgohxVWBeVmcNfSL7rQJ5L+3pZl+OEHdnLYihgxsWhNsbE
 Yzei3P67xvlVgp9gBKvx7IA=
CFBL-Feedback-ID: 6b0aa5db7f49ff6c4aaf7f68:9c58233b47a767d1fe1831a68928480c
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b0aa5db7f49ff6c4aaf7f68
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.39
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2828bc56-1628-4030-a343-5c9578d45311@kwiboo.se>
Date: Sat, 28 Nov 2026 10:58:47 +0100
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: rockchip-sfc: add RK3506 support
To: ZhuXiangyu <1194781887@qq.com>
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chris Morgan <macromorgan@hotmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_B239E24A7651B43AC21C4769D1E75FA0A505@qq.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <tencent_B239E24A7651B43AC21C4769D1E75FA0A505@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi ZhuXiangyu,

On 11/21/2026 8:32 AM, ZhuXiangyu wrote:
> The RK3506 SFC reports version 9 but is compatible with the version 6
> feature set. It needs a power-good handshake through the PMU GRF and
> DLL delay-line training for clock rates above 50 MHz.
> 
> Add the version handling, DLL cell detection and training, and the
> optional power-good poll. Parse the rockchip,max-dll property so boards
> can limit the DLL training range.
> 
> Tested on an RK3506B board with the on-board SPI-NAND at 80 MHz.
> DLL training selects cell 64; read and write are stable.

Bringing up Luckfox Lyra [1] and ArmSoM Forge1 [2] boards I only had to
fix use of x2 clock rate, what issues did you face that delay-line
training and/or npor powergood helped fix?

[1] https://patch.msgid.link/20261125214421.1580359-1-jonas@kwiboo.se/
[2] https://patch.msgid.link/20261126192746.1595707-1-jonas@kwiboo.se/ 

> 
> Tested-by: ZhuXiangyu <1194781887@qq.com>
> Signed-off-by: ZhuXiangyu <1194781887@qq.com>
> ---
>  drivers/spi/spi-rockchip-sfc.c | 201 ++++++++++++++++++++++++++++++++-
>  1 file changed, 199 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
> index a85a260b..bfcad2fa 100644
> --- a/drivers/spi/spi-rockchip-sfc.c
> +++ b/drivers/spi/spi-rockchip-sfc.c
> @@ -14,12 +14,14 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/iopoll.h>
>  #include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi-mem.h>
>  
> @@ -112,7 +114,9 @@
>  #define  SFC_VER_3			0x3
>  #define  SFC_VER_4			0x4
>  #define  SFC_VER_5			0x5
> +#define  SFC_VER_6			0x6
>  #define  SFC_VER_8			0x8
> +#define  SFC_VER_9			0x9
>  
>  /* Delay line controller register */
>  #define SFC_DLL_CTRL0			0x3C
> @@ -168,23 +172,43 @@
>   * 150MHz. No minimum or average value is suggested.
>   */
>  #define SFC_MAX_SPEED		(150 * 1000 * 1000)
> +#define SFC_DLL_THRESHOLD_RATE	(50 * 1000 * 1000)
> +
> +#define SFC_DLL_TRAINING_STEP		10	/* Training step */
> +#define SFC_DLL_TRAINING_VALID_WINDOW	80	/* Valid DLL window */
>  
>  #define ROCKCHIP_AUTOSUSPEND_DELAY	2000
>  
> +struct rockchip_sfc_powergood {
> +	bool	valid;
> +	u32	grf_offset;
> +	u8	bits_mask;
> +};
> +
> +struct rockchip_sfc_data {
> +	struct rockchip_sfc_powergood powergood;
> +};
> +
>  struct rockchip_sfc {
>  	struct device *dev;
>  	void __iomem *regbase;
>  	struct clk *hclk;
>  	struct clk *clk;
>  	u32 speed[SFC_MAX_CHIPSELECT_NUM];
> +	u32 cur_speed;
> +	u32 cur_real_speed;
>  	/* virtual mapped addr for dma_buffer */
>  	void *buffer;
>  	dma_addr_t dma_buffer;
>  	struct completion cp;
>  	bool use_dma;
>  	u32 max_iosize;
> +	u32 max_dll_cells;
> +	u32 dll_cells[SFC_MAX_CHIPSELECT_NUM];
>  	u16 version;
>  	struct spi_controller *host;
> +	struct regmap *grf;
> +	const struct rockchip_sfc_data *data;
>  };
>  
>  static int rockchip_sfc_reset(struct rockchip_sfc *sfc)
> @@ -218,6 +242,33 @@ static u32 rockchip_sfc_get_max_iosize(struct rockchip_sfc *sfc)
>  	return SFC_MAX_IOSIZE_VER3;
>  }
>  
> +static u32 rockchip_sfc_get_max_dll_cells(struct rockchip_sfc *sfc)
> +{
> +	if (sfc->max_dll_cells)
> +		return sfc->max_dll_cells;
> +
> +	if (sfc->version > SFC_VER_4)
> +		return SFC_DLL_CTRL0_DLL_MAX_VER5;
> +	else if (sfc->version == SFC_VER_4)
> +		return SFC_DLL_CTRL0_DLL_MAX_VER4;
> +	else
> +		return 0;
> +}
> +
> +static void rockchip_sfc_set_delay_lines(struct rockchip_sfc *sfc, u16 cells, u8 cs)
> +{
> +	u16 cell_max = (u16)rockchip_sfc_get_max_dll_cells(sfc);
> +	u32 val = 0;
> +
> +	if (cells > cell_max)
> +		cells = cell_max;
> +
> +	if (cells)
> +		val = SFC_DLL_CTRL0_SCLK_SMP_DLL | cells;
> +
> +	writel(val, sfc->regbase + cs * SFC_CS1_REG_OFFSET + SFC_DLL_CTRL0);
> +}
> +
>  static int rockchip_sfc_clk_set_rate(struct rockchip_sfc *sfc, unsigned long  speed)
>  {
>  	if (sfc->version >= SFC_VER_8)
> @@ -321,6 +372,7 @@ static int rockchip_sfc_xfer_setup(struct rockchip_sfc *sfc,
>  {
>  	u32 ctrl = 0, cmd = 0;
>  	u8 cs = spi_get_chipselect(mem->spi, 0);
> +	u32 voltage;
>  
>  	/* set CMD */
>  	cmd = op->cmd.opcode;
> @@ -375,6 +427,15 @@ static int rockchip_sfc_xfer_setup(struct rockchip_sfc *sfc,
>  	dev_dbg(sfc->dev, "sfc ctrl=%x cmd=%x addr=%llx len=%x\n",
>  		ctrl, cmd, op->addr.val, len);
>  
> +	if (sfc->data && sfc->data->powergood.valid) {
> +		if (regmap_read_poll_timeout(sfc->grf, sfc->data->powergood.grf_offset,
> +					     voltage, voltage & sfc->data->powergood.bits_mask,
> +					     1000, jiffies_to_usecs(HZ))) {
> +			dev_err(sfc->dev, "wait for powergood failed\n");
> +			return -EIO;
> +		}
> +	}

Why do we need to check nPOR Power Good state in FSPI driver? Feels
like it may be better handled in PMU driver, use of power domains or
with system PM or something similar?

> +
>  	writel(ctrl, sfc->regbase + cs * SFC_CS1_REG_OFFSET + SFC_CTRL);
>  	writel(cmd, sfc->regbase + SFC_CMD);
>  	if (op->addr.nbytes)
> @@ -521,6 +582,109 @@ static int rockchip_sfc_xfer_done(struct rockchip_sfc *sfc, u32 timeout_us)
>  	return ret;
>  }
>  
> +static int rockchip_sfc_exec_op_bypass(struct rockchip_sfc *sfc,
> +				       struct spi_mem *mem,
> +				       const struct spi_mem_op *op)
> +{
> +	u32 len = min_t(u32, op->data.nbytes, sfc->max_iosize);
> +	int ret;
> +
> +	rockchip_sfc_adjust_op_work((struct spi_mem_op *)op);
> +	rockchip_sfc_xfer_setup(sfc, mem, op, len);
> +	ret = rockchip_sfc_xfer_data_poll(sfc, op, len);
> +	if (ret != len) {
> +		dev_err(sfc->dev, "xfer data failed ret %d\n", ret);
> +
> +		return -EIO;
> +	}
> +
> +	ret = rockchip_sfc_xfer_done(sfc, 100000);
> +
> +	return ret;
> +}
> +
> +static void rockchip_sfc_delay_lines_tuning(struct rockchip_sfc *sfc, struct spi_mem *mem)
> +{
> +	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x9F, 1),
> +						SPI_MEM_OP_NO_ADDR,
> +						SPI_MEM_OP_NO_DUMMY,
> +						SPI_MEM_OP_DATA_IN(3, NULL, 1));
> +	u8 id[3], id_temp[3];
> +	u16 cell_max = (u16)rockchip_sfc_get_max_dll_cells(sfc);
> +	u16 right, left = 0;
> +	u16 step = SFC_DLL_TRAINING_STEP;
> +	bool dll_valid = false;
> +	u8 cs = spi_get_chipselect(mem->spi, 0);
> +
> +	rockchip_sfc_clk_set_rate(sfc, SFC_DLL_THRESHOLD_RATE);
> +	op.data.buf.in = &id;
> +	if (rockchip_sfc_exec_op_bypass(sfc, mem, &op) ||
> +	    (0xFF == id[0] && 0xFF == id[1]) ||
> +	    (0x00 == id[0] && 0x00 == id[1])) {
> +		dev_dbg(sfc->dev, "no dev, dll by pass\n");
> +		rockchip_sfc_clk_set_rate(sfc, sfc->speed[cs]);
> +		sfc->speed[cs] = SFC_DLL_THRESHOLD_RATE;
> +
> +		return;
> +	}
> +
> +	rockchip_sfc_clk_set_rate(sfc, sfc->speed[cs]);
> +	op.data.buf.in = &id_temp;
> +	for (right = 0; right <= cell_max; right += step) {
> +		int ret;
> +
> +		rockchip_sfc_set_delay_lines(sfc, right, cs);
> +		ret = rockchip_sfc_exec_op_bypass(sfc, mem, &op);
> +		if (!ret) {
> +			dev_dbg(sfc->dev, "dll read flash id:%x %x %x\n",
> +				id_temp[0], id_temp[1], id_temp[2]);
> +
> +			ret = memcmp(&id, &id_temp, 3);
> +			if (dll_valid && ret) {
> +				right -= step;
> +
> +				break;
> +			}
> +			if (!dll_valid && !ret)
> +				left = right;
> +
> +			if (!ret)
> +				dll_valid = true;
> +		}
> +
> +		/* Add cell_max to loop */
> +		if (right == cell_max)
> +			break;
> +		if (right + step > cell_max)
> +			right = cell_max - step;
> +	}
> +
> +	if (dll_valid && (right - left) >= SFC_DLL_TRAINING_VALID_WINDOW) {
> +		if (left == 0 && right < cell_max)
> +			sfc->dll_cells[cs] = left + (right - left) * 2 / 5;
> +		else
> +			sfc->dll_cells[cs] = left + (right - left) / 2;
> +	} else {
> +		sfc->dll_cells[cs] = 0;
> +	}
> +
> +	if (sfc->dll_cells[cs]) {
> +		dev_dbg(sfc->dev, "%u %u %u dll training success in %uMHz max_cells=%u sfc_ver=%u\n",
> +			left, right, sfc->dll_cells[cs], sfc->speed[cs],
> +			rockchip_sfc_get_max_dll_cells(sfc), rockchip_sfc_get_version(sfc));
> +		rockchip_sfc_set_delay_lines(sfc, (u16)sfc->dll_cells[cs], cs);
> +	} else {
> +		dev_err(sfc->dev, "%u %u dll training failed in %uMHz, reduce the frequency\n",
> +			left, right, sfc->speed[cs]);
> +		rockchip_sfc_set_delay_lines(sfc, 0, cs);
> +		rockchip_sfc_clk_set_rate(sfc, SFC_DLL_THRESHOLD_RATE);
> +		mem->spi->max_speed_hz = SFC_DLL_THRESHOLD_RATE;
> +		sfc->cur_speed = SFC_DLL_THRESHOLD_RATE;
> +		sfc->cur_real_speed = rockchip_sfc_clk_get_rate(sfc);
> +		sfc->speed[cs] = SFC_DLL_THRESHOLD_RATE;
> +	}
> +}
> +
>  static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  {
>  	struct rockchip_sfc *sfc = spi_controller_get_devdata(mem->spi->controller);
> @@ -540,8 +704,16 @@ static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op
>  		if (ret)
>  			goto out;
>  		sfc->speed[cs] = op->max_freq;
> -		dev_dbg(sfc->dev, "set_freq=%dHz real_freq=%ldHz\n",
> +		sfc->cur_speed = op->max_freq;
> +		sfc->cur_real_speed = rockchip_sfc_clk_get_rate(sfc);
> +		dev_dbg(sfc->dev, "set_freq=%uHz real_freq=%luHz\n",
>  			sfc->speed[cs], rockchip_sfc_clk_get_rate(sfc));
> +		if (rockchip_sfc_get_version(sfc) >= SFC_VER_4) {
> +			if (sfc->cur_real_speed > SFC_DLL_THRESHOLD_RATE)
> +				rockchip_sfc_delay_lines_tuning(sfc, mem);
> +			else
> +				rockchip_sfc_set_delay_lines(sfc, 0, cs);
> +		}

Addition of training and configuring delay lines does not seem to be
related to just RK3506? Should likely be a separate patch.

>  	}
>  
>  	rockchip_sfc_adjust_op_work((struct spi_mem_op *)op);
> @@ -657,6 +829,10 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
>  
>  	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node, "rockchip,sfc-no-dma");
>  
> +	device_property_read_u32(&pdev->dev, "rockchip,max-dll", &sfc->max_dll_cells);
> +	if (sfc->max_dll_cells > SFC_DLL_CTRL0_DLL_MAX_VER5)
> +		sfc->max_dll_cells = SFC_DLL_CTRL0_DLL_MAX_VER5;

Addition and use of a new vendor property should likely also be a
separate patch. And why/how is this something that can or need to be
changed per board? (the devicetree should describe hardware not be used
to configure software)

> +
>  	ret = clk_prepare_enable(sfc->hclk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to enable ahb clk\n");
> @@ -683,11 +859,23 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sfc);
>  
> +	sfc->data = device_get_match_data(dev);
> +	if (sfc->data && sfc->data->powergood.valid) {
> +		sfc->grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
> +		if (IS_ERR(sfc->grf)) {
> +			ret = dev_err_probe(dev, PTR_ERR(sfc->grf),
> +					    "failed to get grf\n");
> +			goto err_irq;
> +		}
> +	}
> +
>  	ret = rockchip_sfc_init(sfc);
>  	if (ret)
>  		goto err_irq;
>  
>  	sfc->version = rockchip_sfc_get_version(sfc);
> +	if (sfc->version == SFC_VER_9)
> +		sfc->version = SFC_VER_6;

Why downgrade the saved version just to workaround the version check for
use of x2 clock rate?, please see [3] for a patch that instead changes
the x2 clock rate version check to fix current x2 clock rate on RK3506,
along with RK3528 and RK3562. That seemed enough to fix SPI NAND issues
on RK3506 for me.

[3] https://patch.msgid.link/20261122174357.1295391-1-jonas@kwiboo.se/

Regards,
Jonas

>  	sfc->max_iosize = rockchip_sfc_get_max_iosize(sfc);
>  
>  	pm_runtime_set_autosuspend_delay(dev, ROCKCHIP_AUTOSUSPEND_DELAY);
> @@ -823,8 +1011,17 @@ static const struct dev_pm_ops rockchip_sfc_pm_ops = {
>  	SYSTEM_SLEEP_PM_OPS(rockchip_sfc_suspend, rockchip_sfc_resume)
>  };
>  
> +static const struct rockchip_sfc_data rk3506_fspi_data = {
> +	.powergood = {
> +		.valid = true,
> +		.grf_offset = 0x100,
> +		.bits_mask = BIT(0),
> +	},
> +};
> +
>  static const struct of_device_id rockchip_sfc_dt_ids[] = {
> -	{ .compatible = "rockchip,sfc"},
> +	{ .compatible = "rockchip,rk3506-fspi", .data = &rk3506_fspi_data },
> +	{ .compatible = "rockchip,sfc" },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_sfc_dt_ids);

