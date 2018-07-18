From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [DISCUSSION] spi multi chipselect support
Date: Wed, 18 Jul 2018 19:19:19 +0200
Message-ID: <c497b0e2-c663-fa29-dabc-6dd5ca26e0a4@metafoo.de>
References: <20180718163530.zsa5md3huz3dnotb@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718163530.zsa5md3huz3dnotb@earth.universe>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/18/2018 06:35 PM, Sebastian Reichel wrote:
> Hi Mark,
> 
> Some SPI slave devices have more than one chip select [0]. Rob suggested
> to use the following DT notation for this [1]:
> 
> spi-controller {
>     slave@0 {
>         reg = <0>, <1>;
>     };
> };
> 
> I think this makes sense from a DT point of view, but this needs
> quite some changes in the SPI core. I tried to find out, how to
> implement the suggestion in the last few days and I see two
> possibilities:
> 
> 1. Register two SPI Linux devices from one DT node. This needs the
>    fewest changes in SPI core. But we loose the one-to-one mapping
>    of DT nodes to devices. I have a feeling, that this will backfire.
> 
> 2. Add support for multiple chip-select to spi_device and modify
>    the transfer functions to make use of this. Unfortunately this
>    would require changing all spi controller as far as I can see?
> 

Hi,

I believe that has been discussed before recently, but I can't find it in
the archives.

My preferred solution would to have something like
i2c_new_secondary_device(), but for SPI. This way the driver that binds to
the compatible string can allocate devices for additional chip selects as
necessary. Also make use of the reg-names property the same way as in I2C.

The only catch here is that locking in the SPI core needs to be re-worked,
since you can't allocate SPI devices from within another SPI device's probe
function. Something like
https://github.com/analogdevicesinc/linux/commit/b5cc8460b959e530413ffbf9b93d8012c80d05df

- Lars
