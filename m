From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date: Thu, 30 Aug 2018 17:49:36 -0700
Message-ID: <153567657639.93865.10810620274753191329@swboyd.mtv.corp.google.com>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, broonie@kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mka@chromium.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Dilip Kota (2018-08-24 03:42:15)
> +
> +static int __maybe_unused spi_geni_suspend(struct device *dev)
> +{
> +       if (!pm_runtime_status_suspended(dev))
> +               return -EBUSY;

This looks odd. Why are we doing this? The i2c driver had a recent fix
from Evan squashed in that removed this logic so that suspend wouldn't
be called twice. Can this driver support the direct_complete PM
mechanism instead? Maybe that works to make this check unnecessary and
also allows us to avoid suspending subdevices and resuming on system
resume? It would be good if the i2c/uart/spi drivers could all agree on
how to handle this.

> +       return 0;
> +}
> +
> +static const struct dev_pm_ops spi_geni_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(spi_geni_runtime_suspend,
> +                                       spi_geni_runtime_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(spi_geni_suspend, NULL)
> +};
> +
