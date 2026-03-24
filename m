Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D59383C79
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340034; cv=none; b=sl5rqMX/0EMGTVMs+V9juNhTULFucK0jMCLMyhfAVyY1fmMO7DJQvn8fkLHurZ0ErQvwwPFVOX6SIH6c2mCUePnfxajh/gx7tZ4xWIZjLbiElLV6zZvFZqeZTNaEwBcbCmVNZ/sjBriSwa5qlQ5BNQcnNsbzPKHQpKKsdnbWeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340034; c=relaxed/simple;
	bh=nHqONSZjdb098tvVQGVqDUIs7yNyqIzIH8MV+w/a2Vc=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=LH3cMGRIM0QwkajmRALdtVpWp+j802Dy+0ENzYSdXZGSpOKmn88KLa/xoo447gY/Rcu09Is4lfaSuvfiLOvZ17ncj6qkndC3bYfi2OUfslkYhcGOliaV1y6DH4BxoHMCafwtwIBr5UrF6So2Rw7+bsaw4pqwDz7ehMqXu7PvVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d76fc66275911f1a21c59e7364eecb8-20260324
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:cc8218af-c463-4ddd-862b-0e6a3ced43f6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:23a5c5945be010a137b780863f6ba5d4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|83|102|817|898,TC:nil,Content:-10|-8|
	-5|14|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d76fc66275911f1a21c59e7364eecb8-20260324
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 385815658; Tue, 24 Mar 2026 16:13:39 +0800
Message-ID: <f1d16bbb-85d2-4906-99b0-28c4b6fdb03e@kylinos.cn>
Date: Tue, 24 Mar 2026 16:13:37 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pei Xiao <xiaopei01@kylinos.cn>
To: ot_meiker.gao@mediatek.com, linux-spi@vger.kernel.org
Reply-To: 20260324062835.1747943-3-ot_meiker.gao@mediatek.com
Subject: Re:[PATCH 2/2] [v3] spi: spi-mtk-nor: Modify and optimization the
 SNFC.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>  drivers/spi/spi-mtk-nor.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index 702339a6c817..6d24932053e5 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -100,7 +100,6 @@
>  
>  #define CLK_TO_US(sp, clkcnt)		DIV_ROUND_UP(clkcnt, sp->spi_freq / 1000000)
>  
> -#define MAX_CLOCK_CNT		6
>  
>  struct mtk_nor_caps {
>  	u8 dma_bits;
> @@ -119,8 +118,8 @@ struct mtk_nor {
>  	void __iomem *base;
>  	u8 *buffer;
>  	dma_addr_t buffer_dma;
> -	struct clk_bulk_data clocks[MAX_CLOCK_CNT];
> -	int clock_cnt;
> +	struct clk_bulk_data *clocks;
> +	u8 clock_cnt;
>  	unsigned int spi_freq;
>  	bool wbuf_en;
>  	bool has_irq;
> @@ -733,19 +732,16 @@ static int mtk_nor_enable_clk(struct mtk_nor *sp)
>  static int mtk_nor_parse_clk(struct device *dev, struct mtk_nor *sp)
What is the baseline you modified, I can't find this code at this link：
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/spi/spi-mtk-nor.c

Thanks！
Pei.
>  {
>  	struct device_node *np = dev->of_node;
> -	int ret;
>  	const char *name;
> -	int cnt,i;
> +	int cnt,i,ret;
>  
>  	cnt = of_property_count_strings(np, "clock-names");
>  	if (!cnt || (cnt == -EINVAL)) {
>  		dev_err(dev, "Unable to find clocks\n");
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	} else if (cnt < 0) {
>  		dev_err(dev, "Count clock strings failed, err %d\n", cnt);
> -		ret = cnt;
> -		goto out;
> +		return cnt;
>  	}
>  
>  	sp->clock_cnt = cnt;
> @@ -760,9 +756,10 @@ static int mtk_nor_parse_clk(struct device *dev, struct mtk_nor *sp)
>  	}
>  
>  	ret = devm_clk_bulk_get(dev, sp->clock_cnt, sp->clocks);
> +	if (ret)
> +		return ret;
>  
> -out:
> -	return ret;
> +	return 0;
>  }
>  
>  static void mtk_nor_init(struct mtk_nor *sp)

