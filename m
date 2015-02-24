From: Andy Gross <agross@codeaurora.org>
Subject: Re: [PATCH v2] spi: qup: Add DMA capabilities
Date: Tue, 24 Feb 2015 16:38:40 -0600
Message-ID: <20150224223840.GA21310@qualcomm.com>
References: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org>
 <20150224135622.GH6236@finisterre.sirena.org.uk>
 <54ECA216.306@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54ECA216.306@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 24, 2015 at 06:08:54PM +0200, Stanimir Varbanov wrote:

<snip>

> 
> yes, there is a potential race between atomic_inc and dma callback. I
> reordered these calls to save few checks, and now it returns to me.
> 
> I imagine few options here:
> 
>  - reorder the dmaengine calls and atomic operations, i.e.
> call atomic_inc for rx and tx channels before corresponding
> dmaengine_submit and dmaengine_issue_pending.
> 
>  - have two different dma callbacks and two completions and waiting for
> the two.

This is probably the better solution.  The only thing you'll have to take into
consideration is that you may not have a RX DMA transactions.

> 
>  - manage to receive only one dma callback, i.e. the last transfer in
> case of presence of the rx_buf and tx_buf at the same time.

You use separate channels for the RX and TX, so as long as you have separate
callbacks, it shouldnt be a problem.


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
