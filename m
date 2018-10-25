From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Simplify probe function
Date: Thu, 25 Oct 2018 13:06:52 -0700
Message-ID: <CAD=FV=VUB6jxQE61eXdFQBcc45uLz5Lc9PO2K4pmOY=6PjNDnQ@mail.gmail.com>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org> <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
To: alokc@codeaurora.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Thu, Oct 25, 2018 at 9:40 AM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> Re-arrange existing APIs in probe function to
> avoid using goto and remove redundant variables.
>
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 49 ++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)

I agree that this is what Stephen was looking for in his review
feedback.  I personally thought it was fine the way it was but I have
no objections to this.  Thanks for following up.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
