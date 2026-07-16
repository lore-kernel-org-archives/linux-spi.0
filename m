Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC823C141F
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209862; cv=none; b=VCHPZzXtZ/BbIU9N/MHC4GEUlncOq4XZe9Q5ZXHLxs0g3EjZ9ON4aB+5fcYkf/QHMPA7TP7OffZszbcqTdSM7xkwe9yR/P5xiJkHq0rPsIU9kjHUc2ZeavU0AXjlSIPRXn8jBMdacmz7MxaomVxm653g3QzRQcEYfrEqgXfddqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209862; c=relaxed/simple;
	bh=LtCVk3GlRvz5O/3cpR8WnyAUtXQ+EmvpDFP2wCdQ7gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur2fSSLJSBIqZSdjnQscmIV7IBHVn8RJ1w9ipBL9d3CHjRGj/2fIvkKzrCbCLYn+SIHj0eNwHaoJCV12WSN+UHwEczxnNZ43/gjSumgLnCsP7Gx5g2n4S3BEby7oJpbpq0ji4OPy7b+dhw5izp9fw2w1npvtfqjERazy88Uu31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0C4XiTc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0C4XiTc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69c82519403so875480a12.3
        for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784209859; x=1784814659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0lc7I38yh7L/gqBncqtshTplNceE/IFKEhJvkcN3z1E=;
        b=T0C4XiTcMLFLW2jbfq8QujKdiZe3I6jI/rxrlP6ZR1/UmYxFjFUfj3SPe4S8L/tLM6
         B9dJDlQkJS+v2GDWGbNqVQu2+CnJMzYyryz0sJgujI5NKNiaYpGo8jvtTYW2TJpVAlNB
         scF5cH5Hpvt4Jt4BJ6otS+mNMRrvx2xzc6GpVrFYAz82RpYmewopFFKH7mMEy7JlBuuu
         1sYm1DDPj9Q/U7ZWM4Qk0qG4g7EoFdZXEoS7bEjhU8ME/6pwzTfp/rZvJvCfqYouQewu
         MdsrT2TXCqHYHgSVw1EM/9udnEHnZvmXNTA/a20eygBhpYbuusfyVhTghBwqbUA9WtkT
         ucpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784209859; x=1784814659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0lc7I38yh7L/gqBncqtshTplNceE/IFKEhJvkcN3z1E=;
        b=Bb8OXp7LRn/64iJprLNcFJfmIqWp/50dQYGR/yVAMjZ9Q5ARP0MrTV6woge2LzsA+a
         Dnx/sZKKLrvZ19PU7TLjNIsoV39oH2YspX7eKkEam3sAwalLQknyx/6/o3V51WvkUnOr
         ujhP7Bvg5rxVO6YdC0W9+qeuV3RPLdglU1zcmEHhpmVVz2xa2QcHmsTEgv3k/uLiIjrV
         wwE42A5T2WZAzcX9/Vq6xJ6tL2+u/Q1eNpyqZn0xbAB8Z2mf2wxiGR1VWTndA/r3RhBJ
         VhSUhP+dkwDUXXJ5q/lnT7vPnfYNIFuQTihaX/lxWgHvoIlp1U0Gd32ZB24ecvC7fwfl
         fWjA==
X-Forwarded-Encrypted: i=1; AHgh+Roi4a0D4w9s4GcUvrZR3WmTRADFoKsD9HxGueDBF3C9NlqUW/aGr9WTle3V6AHKP0Oz3/9KQtYrBhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wuTYgOorLvFQOW/TuWTD4PVkMnsy9RQwdXcmFMY/8zkH5T7G
	sEg4269apCN32wvW+OeB723w1RAGykCYyb9C4bad4R5OngJrVMlr4PCO
X-Gm-Gg: AfdE7ckTru16xoHfhwBmZ74hmqaJclANHFIRMInKydt1EOrmzfDwKFZkB3GA+fFsr42
	HfUh6K6rYdbRQ1i+z8RNjd20Me80wZYAtW51TisEGOez6iZsWVLSsjVpxx84zLb0gelkWyPbgKr
	x886vA1jnglEbkMvBKaxVSn1otOXj8zfkyeGv2B/pBmzDsQN8aZdI1KknVOIr0atUieUVfp9QAd
	da6DxEXxhtH6vpDMZUSDEB2DH1GNETnpCd97ggE+ZHpRIEwlpw40mcWtgzc/cxJySi2NcXhckMQ
	VS9ZiL3/ThtQ6qiQw8bwhRYZka6Y1fg6YeUx8zUhkWBBlup3oVpMM4GZfy3fEonqQsO+osG0lcQ
	RfOCed8A1rTw3XhxMsSDwMJX++9A+swIKUbsZbTwnHg1K8vmVKxeYYonof7nODWTAkUe9MKqyau
	f9eym+RxBA6iwTmuUDEpZlK3Ym8g8H9vJu
X-Received: by 2002:a05:6402:2694:b0:699:6415:751e with SMTP id 4fb4d7f45d1cf-69c5f130032mr5962038a12.4.1784209858553;
        Thu, 16 Jul 2026 06:50:58 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e12ccd067sm2823890a12.21.2026.07.16.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:50:57 -0700 (PDT)
Date: Thu, 16 Jul 2026 13:50:37 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com, michael.hennerich@analog.com,
	broonie@kernel.org, marcelo.schmitt1@gmail.com, andy@kernel.org
Subject: Re: [PATCH 0/6] spi: add multi-CS and per-transfer lane mask support
Message-ID: <alkL3Sh7kmq7Yr1c@JSANTO12-L01.ad.analog.com>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <eplbtsrc2rojtpuxdtcy7vp63fhzl4ckb5cobs45y6fmcjy3wj@g3ccws2qeg2d>
 <6576af52-19d1-4b79-879e-bbd09df40a7a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6576af52-19d1-4b79-879e-bbd09df40a7a@baylibre.com>

On 07/14, David Lechner wrote:
> On 7/14/26 5:29 AM, Nuno Sá wrote:
> > On Tue, Jul 14, 2026 at 02:55:31AM -0300, Jonathan Santos wrote:
> >> This series introduces two SPI subsystem features: per-transfer chipselect
> >> masks and multi-CS device support. Together they address the multi-device
> >> setup described in [1] and the limitation noted in [2], where no SPI
> >> controller completely handles logical chip selects beyond the first one.
> >>
> >> The first part of the set addresses multi-CS support. Some SPI controllers
> >> can assert multiple chip selects simultaneously, but the existing code
> >> hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
> >> preventing this from working.
> >>
> >> The second part addresses dynamic lane selection for STRIPE mode. In
> >> SPI_MULTI_LANE_MODE_STRIPE, all available lanes are currently always
> >> active. Some peripherals need to select a different subset of rx/tx lanes
> >> per transfer. New fields are added to the spi_transfer struct to allow
> >> drivers to specify which lanes to use for each transfer. The documentation
> >> is also updated to describe this new behavior.
> >>
> >> [1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
> >> [2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/
> >>
> >> Jonathan Santos (6):
> >>   spi: support simultaneous assertion of multiple CS
> >>   spi: add per-transfer CS mask
> >>   spi: spi-engine-ex: Add support for multi-CS devices
> >>   spi: Documentation: multiple-data-lanes: describe rx and tx lane mask
> >>   spi: add rx and tx lane mask to spi_transfer struct
> >>   spi: axi-spi-engine: add support for dynamic multi-lane selection

Hi david,
Thanks for the suggestions!

> > 
> > It would be nice to include an actual user for this in the series.
> 
> Agree.
> 
> For context, here is the scenario from [1] (with arrow directions fixed):
> 
> +---------------+                                                 
> |     ADC 0     |                                                 
> |               |                                                 
> |        SYNC_IN|<--+---------------------------+                 
> |          DRDY0|---|------------------------+  |                 
> |               |   |                        |  |   +------------+
> |          SCLK0|<--|------+                 |  |   |    HOST    |
> |           SDI0|<--|------|--+              |  |   |            |
> |            CS0|<--|------|--|-----------+  |  +---|ADC_SYNC    |
> |          DOUT0|---|------|--|--------+  |  |      |            |
> |               |   |      |  |        |  |  |      |            |
> +---------------+   |      +--|--------|--|--|------|SCLK        |
>                     |      |  +--------|--|--|------|MOSI        |
> +---------------+   |      |  |        |  |  |      |            |
> |     ADC 1     |   |      |  |        |  |  |      |            |
> |               |   |      |  |        |  |  +----->|DRDY0       |
> |        SYNC_IN|<--+      |  |        |  +---------|CS0         |
> |          DRDY1|---|------|--|----+   +----------->|MISO0       |
> |               |   |      |  |    |                |            |
> |          SCLK1|<--|------+  |    |                |            |
> |           SDI1|<--|------|--+    +--------------->|DRDY1       |
> |            CS1|<--|------|--|---------------------|CS1         |
> |          DOUT1|---|------|--|-------------------->|MISO1       |
> |               |   |      |  |                     |            |
> +---------------+   |      |  |                     | .          |
>                     |      |  |                     | .          |
>        ...          |      |  |                     | .          |
>                     |      |  |                     |            |
> +---------------+   |      |  |            +------->|DRDYN       |
> |     ADC N     |   |      |  |            | +------|CSN         |
> |               |   |      |  |            | | +--->|MISON       |
> |        SYNC_IN|<--+      |  |            | | |    |            |
> |          DRDYN|----------|--|------------+ | |    +------------+
> |               |          |  |              | |                  
> |          SCLKN|<---------+  |              | |                  
> |           SDIN|<------------+              | |                  
> |            CSN|<---------------------------+ |                  
> |          DOUTN|------------------------------+                  
> |               |                                                 
> +---------------+  
> 
> 
> And the proposed DT from the discussion in [1].
> 
> spi {
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     adc@0 {
> 	compatible = "adi,adaq7768-1";
> 	reg = <0>, <1>, <2>, <3>;
>         
>         spi-rx-bus-width = <1>, <1>, <1>, <1>;
> 
> 	/* other properties */
>     };
> };
> 
> As a refresher, the idea is that this is considered to be one big ADC
> with more channels (for simultaneous sampling) even though it is
> physically multiple chips. 
> 
> Currently, this series is treating CS selection and mutli-lane SPI line
> selection as completely independent. However, clearly certain spi-rx-bus
> lines are tightly coupled with certain CS lines.
> 
> To reflect that (and easier to use in peripheral drivers), I think we
> could bake this correlation into the SPI core code.
> 
> So struct spi_device.rx_lane_map would become a 2-D array where the
> first index is the logical CS (following the pattern of .chip_select)
> and the second index is the existing one for the data lane.
> 
> The trivial implementation would be to assume that reg and spi-rx-bus-width
> have the same length and there is just a 1-to-1 correspondence (first data
> lane is associated with first CS, and so on).
> 
I like the idea of binding the CS to rx/tx lanes. I have a concern though: could this 1-1 correspondence break the current implementations where we have multiple data lanes per channel and only one CS? (and in those cases spi-rx-lane-map is ommited, so it is used the default mapping based on the spi-rx-bus-width). 

Also, could we extend the ancillary device framework to deal with the multiple data lanes? Maybe it is easier to bind the logical CS with the data lanes in there because there is the assumption of sub-devices with multiple CS (even if we don't use the ancillary device for this case).

> And we could add a new DT property for more complex mappings (multiple
> data lanes per CS or wires not connected in logical order). We probably
> don't need to do that right now though if there are no expected users
> at the moment.
> 
> Then we would only need to add the CS selection to struct spi_transfer
> and the controller driver would just use the map to pick the correct
> data lanes based on other parameters as it does now. (So no need to
> add .rx_lane_mask to struct spi_transfer.)
> 

Yes, this is less prone to mistakes.

> This way, the ADC (SPI peripheral driver) can set 1 CS in order to
> configure individual chips and then set all CS to read sample data.
> And all of the data lane selection is all handled transparently between
> the core SPI code and the SPI controller driver.
> 

Another concern with the CS selection is how to handle this in the
driver using regmap (i will add the driver patches in the next version).
I Created custom regmap write and read handlers and a regmap instace for
each sub-device. Each instace have a context data with the corresponding
CS mask, but it looks overcomplicated. Dealing with this correlation in
the ancillary would be simpler. Don't know if this makes sense.

> (And obviously everything above applies to tx too, I just wrote rx
> everywhere to keep it shorter.)
> 
> > 
> > - Nuno Sá
> > 
> >>
> >>  Documentation/spi/multiple-data-lanes.rst |  30 ++++++
> >>  drivers/spi/spi-axi-spi-engine.c          | 106 +++++++++++++++++-----
> >>  drivers/spi/spi.c                         |  97 +++++++++++++++++---
> >>  include/linux/spi/spi.h                   |  12 +++
> >>  4 files changed, 206 insertions(+), 39 deletions(-)
> >>
> >>
> >> base-commit: 093239070573637ad2b4cb56abc9c4c7ee109294
> >> -- 
> >> 2.34.1
> >>
