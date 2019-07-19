From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/4][V2] dt-bindings: iio: imu: add bindings for ADIS16460
Date: Fri, 19 Jul 2019 16:49:37 -0600
Message-ID: <CAL_JsqKZMoxdH_rpyD9kTEPtFZ=QxEV325wH=6qdhNX2nS=9ug@mail.gmail.com>
References: <20190717115109.15168-1-alexandru.ardelean@analog.com> <20190717115109.15168-5-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717115109.15168-5-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 17, 2019 at 5:51 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> This change adds device-tree bindings for the ADIS16460.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/imu/adi,adis16460.yaml       | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
