Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ACFC11F68
	for <linux-spi@archiver.kernel.org>; Tue, 29 Jun 2021 03:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9860B61D3E
	for <linux-spi@archiver.kernel.org>; Tue, 29 Jun 2021 03:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhF2DkH (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 28 Jun 2021 23:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhF2DkG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Jun 2021 23:40:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6442561D38;
        Tue, 29 Jun 2021 03:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624937859;
        bh=wvinFt0qcp97HAcqwxqlfrjB2zJAOfcgDtrhX0/nJus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhGlkF14cvJcmHhIFuloHFwYL4Wx1SyKAMrqA1zLfRSl3/5l12d5nvvZiRn2TKdcW
         eoePSsj9I6PM4ugrq+mvkwHfz9BBxtR/zxkrlyJItvRlF6rrxY2ybi4ivcXXVdjF0m
         xDJxv5g21kdxmwrDhifiRMLsAPQ55KJaFZPVBr/WWKwG2u9lwgwLePwLaT76/6p80X
         1ny7s0KtI8cIbiQnmkSoEoLJ7+v8NXdDZLkekkkjvzTsyJXhQjmaPO8i0P/sA/sVZa
         bmcC5DGIHYBQpU6LvOffiM8qA8Tewt0mws+MZIj00AplWkAQ/Qc+hieiJLnsj/N9xF
         wRtvsb5G//inQ==
Date:   Tue, 29 Jun 2021 09:07:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] soc: qcom: geni: Add support for gpi dma
Message-ID: <YNqVgESqehz27knL@matsya>
References: <20210625052213.32260-1-vkoul@kernel.org>
 <20210625052213.32260-3-vkoul@kernel.org>
 <CAD=FV=ULVo=vz2Vww6_bcfrhosy0GRC2oVEcXt6zw8n4C2MiuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=ULVo=vz2Vww6_bcfrhosy0GRC2oVEcXt6zw8n4C2MiuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Doug,

On 28-06-21, 16:38, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 24, 2021 at 10:22 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > +static void geni_se_select_gpi_mode(struct geni_se *se)
> > +{
> > +       u32 val;
> > +
> > +       geni_se_irq_clear(se);
> > +
> > +       writel(0, se->base + SE_IRQ_EN);
> > +
> > +       val = readl(se->base + SE_GENI_S_IRQ_EN);
> > +       val &= ~S_CMD_DONE_EN;
> > +       writel(val, se->base + SE_GENI_S_IRQ_EN);
> > +
> > +       val = readl(se->base + SE_GENI_M_IRQ_EN);
> > +       val &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN |
> > +                M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
> > +       writel(val, se->base + SE_GENI_M_IRQ_EN);
> > +
> > +       writel(GENI_DMA_MODE_EN, se->base + SE_GENI_DMA_MODE_EN);
> > +
> > +       val = readl(se->base + SE_GSI_EVENT_EN);
> > +       val |= (DMA_RX_EVENT_EN | DMA_TX_EVENT_EN | GENI_M_EVENT_EN | GENI_S_EVENT_EN);
> 
> nit: the above has some extra parenthesis that aren't needed.
> 
> I will continue to assert that all of the "set mode" stuff doesn't
> really belong here and should be managed by individual drivers [1].
> I'll accept that it doesn't have to block forward progress, though I'm
> at least a bit disappointed that we asked Qualcomm to do this over 8
> months ago and no action was taken. :(
> 
> In any case, this looks OK to me:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks for the review.

> 
> [1] https://lore.kernel.org/r/CAD=FV=VWPqswOXJejyXjYT_Yspdu75ELq42cffN87FrpTwPUQg@mail.gmail.com/

I agree we should do something, will discuss with Bjorn and try to help
here.

Regards
-- 
~Vinod
