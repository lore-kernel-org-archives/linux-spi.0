From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Simplify probe function
Date: Sat, 03 Nov 2018 19:36:39 -0700
Message-ID: <154129899939.88331.3391593549002723465@swboyd.mtv.corp.google.com>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
 <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
To: Alok Chauhan <alokc@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Alok Chauhan (2018-10-25 09:40:29)
> Re-arrange existing APIs in probe function to
> avoid using goto and remove redundant variables.
> =

> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
