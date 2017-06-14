From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH 01/18] spi: qup: Enable chip select support
Date: Wed, 14 Jun 2017 12:47:05 +0300
Message-ID: <41827ac4-fe95-d07d-095d-3c78f6fbded1@linaro.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
 <1497419551-21834-2-git-send-email-varada@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Sham Muthayyan <smuthayy@codeaurora.org>
To: Varadarajan Narayanan <varada@codeaurora.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1497419551-21834-2-git-send-email-varada@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 06/14/2017 08:52 AM, Varadarajan Narayanan wrote:
> Enable chip select support for QUP versions later than v1

Could you be more descriptive here because in the git history of the
driver there is a commit "4a8573abe965115bc5b064401fd669b74e985258 spi:
qup: Remove chip select function" which removes chip select
functionality. So this patch leads to a situation where we use gpio cs
for qup_v1 and not for next versions!?

> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  drivers/spi/spi-qup.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

<snip>

-- 
regards,
Stan
