From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] spi: dt-bindings: Convert spi-sifive binding to json-schema
Date: Wed, 18 Sep 2019 08:44:39 -0500
Message-ID: <CAL_JsqJhH2x6xto9yJ+0V5YiYn9J_Y_bABG4_N6MK0M3XFCPqg@mail.gmail.com>
References: <1568804927-13565-1-git-send-email-pragnesh.patel@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Pragnesh Patel <pragnesh.patel@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568804927-13565-1-git-send-email-pragnesh.patel@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 18, 2019 at 6:10 AM Pragnesh Patel
<pragnesh.patel@sifive.com> wrote:
>
> Convert the spi-sifive binding to DT schema format.
>
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>
> Changes in v2:
> - Remove address-cells and size-cells property
> - Added valid values for sifive,fifo-depth and sifive,max-bits-per-word
>   property
>
>  .../devicetree/bindings/spi/spi-sifive.txt         | 37 ----------
>  .../devicetree/bindings/spi/spi-sifive.yaml        | 86 ++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
