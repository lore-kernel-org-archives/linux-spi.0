Received: from smtpout7.mo534.mail-out.ovh.net (smtpout7.mo534.mail-out.ovh.net [54.36.140.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F86223DC6
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168275; cv=none; b=I1edQxrF6eCEzP8oV5aUQsx9UAVicJwn6xhVTtFT06F5RJJAdQ0kgKWyFoZK/o4WuSYkgk35de9F4OW3bzeqCA36mcs6lmzWYYxE/UAYgPdRX3w1EJT86wFsoxZtK9gR6o+7hUZU4AsSUE1Ecjf995DW6GMV+4p5NPibiIfTGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168275; c=relaxed/simple;
	bh=bNZwWR9Ss2hhRC2v3drqLRBhMt8fKRMZWJUoR6d54Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXIKSQ/rhndKeDPOlHDQCGxGXzn30s2YY0HD1iJi7OqviHOq0aStKrcNDESDdfPSHhJFUVBVCjVEgm2HFa1Ovzpr9IdXeyFoPS/pJAz4qYYIWX0fHZSjKk401x8izzklCh6hp+iMam5jyI3ONnb7hY07yvU6JrcJYuNlPYQaGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaod.org; spf=pass smtp.mailfrom=kaod.org; dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b=NTAl8pTO; arc=none smtp.client-ip=54.36.140.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaod.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaod.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b="NTAl8pTO"
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net [51.68.94.138])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gKNDc3GXgz6LD6;
	Tue, 19 May 2026 05:16:00 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net. [127.0.0.1])
        by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <BMC-SW@aspeedtech.com>; Tue, 19 May 2026 05:16:00 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.103])
	by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gKNDc13kDz7tlG;
	Tue, 19 May 2026 05:16:00 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
	(Authenticated sender: clg@kaod.org)
	by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id C2A1212E3B4C;
	Tue, 19 May 2026 05:15:58 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-99G0039684dcb8-cd63-49a4-92c8-9921fee0f866,
                    A1C5BDF50025601E7F63D663DE463AD2E6007479) smtp.auth=clg@kaod.org
X-OVh-ClientIp:82.64.250.170
Message-ID: <f35f2b40-2fa1-4436-923f-218de21f6320@kaod.org>
Date: Tue, 19 May 2026 07:15:58 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: aspeed: Fix missing __iomem annotation in output
 transfer path
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, broonie@kernel.org,
 joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 BMC-SW@aspeedtech.com
Cc: kernel test robot <lkp@intel.com>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
 <20260518095708.2502537-2-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260518095708.2502537-2-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17442441358158310602
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEoerUWSzNGZsjx9uoa6SmO8zT4p/z6+hEkbPVZhZ2bJRf5AqxAZW0Bgc1XJ39p7LXNVhXaj1s7wWqfUv7KnO8OBJ8j/XLCfXpLHAClORp/zYHonr6Vh44S8Th1hbq12FUEhiQB7Hg17bvbBfJDgtMp+AgFaLdGfooUraH3d9VOHKQN1tzBLaPsNPakAPlbrgqLZL0QwDUhG0MUyFPgb2rixXGkRs7anp7Q1k7/VL7qdmvJmaRFq6mcx6IfLyZ88H3D88QUBtKKmBU5DWLYnjdiCs4pPsv26+CPu1LDOq+GmRmCXxB7YZlgaMLha9zLisE6oXQdKKin9A2UdTcDQ3VDh4C+sQQlEUrjlp6JIQSLLCdOVotNQqFKXhRyF7vyKMbH9EDw0esY1oLfCG5cHycRKoDNZ6qbs/J/Ju1vXg1GY1f+hEOcrxcAneFZh7nHNGjvyyOW8EmuVMjkPmLmvG3GoBNICB2oDbG+Hdl0nZO7Nf1DNq3ECmHAOw/i6mi+hhO4r82xb0ft+ULMqHhybjJeuMHmPean1e8pVKo0Q6Fe2H7+fCg4+jEGSISaeT04zRMIfpaNn7dyyewg1ug7W9R7nFAW+4phNgmoHEyaAHLZWiZq4pzniv9GyGn63bCF7lBWcoSpYC1uF4lyEsiIP8xyZ9eSHyF6FPqL4CFWMzx0/g
DKIM-Signature: a=rsa-sha256; bh=7/eczqgb5pHTFq3/P6vC9IlXxV8mPvvQMR8RQBbx5Us=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779167761; v=1;
 b=NTAl8pTOFP4+gFRE4i/CND2oNcXxbhLDUhUcuf1G4tTs4X9/dqPQ8KTOuAjuMgpXxf6SMSfc
 /2/0wAT4I7GRQYPuowIsr27rmeBCKlTOPgVTwT8IqIBz03/S6DWb7Kcvni9YuBesXaCP5JpUOMB
 3Z56yyIBalrVcwg3ThCwSbfBm4CEZDMM8KvppfNUNPN0119ulwtsHYaoyPC+y1F1mkcKWU5g6rK
 2X2WAcMI5Sik5S740Sp0Or7YDCGQAgtsN00FbyyQv6REitHHh4y18te7qZgzGc4h5QddYKK7URw
 jvh4k27GEh5/IxERfhmVBULYtbX51qRuoqRPVpEEwFMkQ==

On 5/18/26 11:57, Chin-Ting Kuo wrote:
> The dst parameter of aspeed_spi_user_transfer_tx() is an MMIO address
> obtained from chip->ahb_base, but it was typed as void * instead of
> void __iomem *.  This caused a sparse warning report. Fix the
> parameter type to void __iomem * and drop the now-unnecessary
> cast at the call site.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@intel.com/
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>   drivers/spi/spi-aspeed-smc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index c21323e07d3c..808659a1f460 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -891,7 +891,7 @@ static int aspeed_spi_user_unprepare_msg(struct spi_controller *ctlr,
>   static void aspeed_spi_user_transfer_tx(struct aspeed_spi *aspi,
>   					struct spi_device *spi,
>   					const u8 *tx_buf, u8 *rx_buf,
> -					void *dst, u32 len)
> +					void __iomem *dst, u32 len)
>   {
>   	const struct aspeed_spi_data *data = aspi->data;
>   	bool full_duplex_transfer = data->full_duplex && tx_buf == rx_buf;
> @@ -936,7 +936,7 @@ static int aspeed_spi_user_transfer(struct spi_controller *ctlr,
>   			aspeed_spi_set_io_mode(chip, CTRL_IO_QUAD_DATA);
>   
>   		aspeed_spi_user_transfer_tx(aspi, spi, tx_buf, rx_buf,
> -					    (void *)ahb_base, xfer->len);
> +					    ahb_base, xfer->len);
>   	}
>   
>   	if (rx_buf && rx_buf != tx_buf) {

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

