From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 17/28] drivers: Introduce bus_find_device_by_of_node()
 helper
Date: Tue, 9 Jul 2019 10:19:22 -0600
Message-ID: <20190709161922.GA1609@bogus>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-18-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, suzuki.poulose@arm.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-i2c@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa@the-dreams.de>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560534863-15115-18-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 14 Jun 2019 18:54:12 +0100, Suzuki K Poulose wrote:
> Add a wrapper to bus_find_device() to search for a device
> by the of_node pointer, reusing the generic match function.
> Also convert the existing users to make use of the new helper.
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: devicetree@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-spi@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c             |  7 +------
>  drivers/hwtracing/coresight/of_coresight.c | 11 ++---------
>  drivers/i2c/i2c-core-of.c                  |  7 +------
>  drivers/nvmem/core.c                       |  7 +------
>  drivers/of/of_mdio.c                       |  8 +-------
>  drivers/of/platform.c                      |  7 +------
>  drivers/spi/spi.c                          |  9 ++-------
>  include/linux/device.h                     | 12 ++++++++++++
>  sound/soc/rockchip/rk3399_gru_sound.c      |  9 ++-------
>  9 files changed, 23 insertions(+), 54 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
