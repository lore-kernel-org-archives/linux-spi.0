From: alokc@codeaurora.org
Subject: Re: [PATCH 0/2] spi-geni-qcom: Cleanup nitpicks and simplify probe
 function
Date: Thu, 25 Oct 2018 22:23:04 +0530
Message-ID: <b391e2df12e31be9ba5e48f197a86471@codeaurora.org>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: swboyd@chromium.org, dianders@chromium.org,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2018-10-25 22:10, Alok Chauhan wrote:
> This patch series fixed the following:
> * nitpicks from the previous review
>  (https://patchwork.kernel.org/patch/10624849/)
> * Cleanup probe function by re-arranging existing APIs to starting of
>   function and hence avoiding one goto jump and remove few redundant
>   variables.
> 
> Alok Chauhan (2):
>   spi: spi-geni-qcom: fix nitpicks
>   spi: spi-geni-qcom: Simplify probe function
> 
>  drivers/spi/spi-geni-qcom.c | 64 
> +++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 34 deletions(-)

Added more folks as some them got missed by get_maintainer.pl for this 
patch.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
