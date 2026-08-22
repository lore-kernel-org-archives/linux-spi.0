Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC54179A3
	for <linux-spi@vger.kernel.org>; Sat, 22 Aug 2026 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357413; cv=none; b=JlrRoLnha7qexZ1ELJAVUO3PO70ZBlLSxu3jmo/CZQFTIScAcK0rVICbsZ8EH+nLagEb1TSCyfVmmaJK3MLFf/7d2EobFhQu+LTqTavO81Q8K4vwqqOAQYXDpbTd4q0cyv8InDBfuGVUTfG4AoHD0ZexNu0YpICpVKXKSJOZAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357413; c=relaxed/simple;
	bh=ljgVH5R2UqL+37w7WoszSNApgkKhRcFs9vU5x/Aw4xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMXihs94/xVKFMxN+T3X3yFl2Um0eYDfw8aJ4/LVgbKqfTBDLIGmbzTX9WUMYd5NDpPhgJN3lk2JOFiBevYUx3wwsPQ/vgICa4JR8C6T8nSuTbqF1yZfhKnGgAfbZhKr3sewfW+ISvujsoXoHYVl4FX23jZW7dQj5FTvl/98TKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzTLLHOp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzTLLHOp"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbe4592c193so139947a12.3
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787357411; x=1787962211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M5mcreu7WlLNkBkV+fdn8TnaUZHLtsn3Ngf2FoTW8cc=;
        b=DzTLLHOpmaBI0DMKbnZoRAuJFnwmWKVN9dQ1A+InXgTj726sb2hKB90GQDAlxjv35I
         rw9rANH/wl02yhVFlBOBdAwmfL8W/OldCHRBAblHkaUjC++VBN9Xgk31rpv9Cf/FQp6C
         uz0DzKxL38dhR+i8wGuDHK3azNSFNOQM19lOGEGGzYS2rW0WDXZgjfHcxVReC42wNUvc
         /yvBTcUtuo4H6iW18oYQKEt9XxUzni08iVaCcbLHiR6jnb1+Q6VBjZwwrg0OmemvkEKW
         Vn/UeyD5WDEzK+JRQaWjKVNaSO2aE2H84NkbKbcIIdt+4SbBz/BStw4X9Pf1qAegCz8+
         DnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787357411; x=1787962211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M5mcreu7WlLNkBkV+fdn8TnaUZHLtsn3Ngf2FoTW8cc=;
        b=Hb6LGBsbsv6UaGVtYVqxuIQpFNMDnhdDkgxayadFM4Kk2MTc2zojnPA3f9fq0EacIe
         kJCQhWRWB2uoB+KOevEdc7XNoF+geJkX9jvxRKgIU7V5TR1kzOrMUtlrvWpUSilqRmuA
         2uuGzk2pn/tSh67AFAnn9bHj3bnS6EaJAlLAStyUhlBsQMhHJT8EkSp3o2Ac4NeuK8yg
         z5g0aAbPWSUzlv11Tyd/R9I7vVj3QKcTQhrFl2J0Kxh+KcScgBMqRi6Q3tVOFmZ/2dBc
         Zv8v26zSBkiVMolt+MWKeOtVTNv/e/iPo5KEcmL2s3s0zwxki0W0//EZ3WXDMGW8tH5+
         wyVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsNX+6uK6HAdGCQ438NW8i3eyuMRUSj5jNr9UB7dWjZyJ359AdJvsi27c/UC96hUD59f04U892ta0=@vger.kernel.org
X-Gm-Message-State: AFuF++ljhbQ8DzjDApzYvePa6KyFdXXnhXnX4BQatb1f03SFZwiUnfsp
	yce9tTN/zW4HcqhAaDgKTaMq6BKDdIO5P1sLr7BUjyaQuKBuCrGRwY4c
X-Gm-Gg: AR+sD13FKRuk5ya4M24YtgopJJhTN7q0phwd3VXjdbJ/BZIBuOynTLPe4seIatvuIKR
	/DyCT0cgQV7w8BPn3Tgwf2Pz/vshsbXs1oYPrHjOjNnUUxbEk8I3d5zINjyAO6OJi+noL5FEOVT
	HHyKOQFkH/Uda7jOo2k7V9I5sbG8SupQ6rUGRVuQ9CSO++EV3crB0h4yxOeGg/BKkZWnuvwTkR1
	FZiwCluZZ7ykDRbSJzZd3ch1Ta8onPWqI0NCngETqeqXWgFiqQM25quvHzdSlu+hA91akZvkVDU
	B6pbP+URM6kjpr2UvWfkKemsqwnGWx60OXom6+h7/MZFG+ErKmhZfZg066a+YhtGdIw6R8MnBF6
	WxTv5/opPT5ekbhIgAgEkY7n6b0RNNnjfPqtZgf4fDHOKO4f8uCLxC+5gx3p8ZaqCGVMjA61kvd
	tmUeIB7Cvivdyzn4WY6VOSdj5xbbwIBV6xD+hHr+4eZcGezRevePzMT4v5KzX+UogpO7CPef6Y6
	dP8
X-Received: by 2002:a17:903:3b84:b0:2cc:f4d4:29a0 with SMTP id d9443c01a7336-2d64b0a908emr88331825ad.3.1787357411167;
        Fri, 21 Aug 2026 17:10:11 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.9.82.144])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90999fcsm464825eec.1.2026.08.21.17.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 17:10:10 -0700 (PDT)
Date: Fri, 21 Aug 2026 21:10:03 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	marcelo.schmitt1@gmail.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v3 2/6] spi: support simultaneous assertion of multiple CS
Message-ID: <aojo2zHCrBPmt9S/@JSANTO12-L01.ad.analog.com>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <e8870b405f29cc89439701d1fcc7e88781aaab22.1786973376.git.Jonathan.Santos@analog.com>
 <e2016946-83e8-46f5-975d-634a219417e7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2016946-83e8-46f5-975d-634a219417e7@baylibre.com>

On 08/18, David Lechner wrote:
> On 8/17/26 6:32 PM, Jonathan Santos wrote:
> > Some SPI controllers allow multiple CS lines to be toggled at the same
> > time. The existing code always used CS index 0 when tracking the last
> > active CS in spi_set_cs(), and unconditionally set cs_index_mask to
> > BIT(0) when parsing DT, both forcing the single CS usage.
> > 
> > Modify spi_set_cs() to iterate last_cs[] using each logical CS index
> > instead of always reading index 0. Modify of_spi_parse_dt() to build
> > cs_index_mask from all parsed CS entries rather than hardcoding BIT(0),
> > so the controller correctly identifies which CS lines belong to a device
> > when asserting them simultaneously.
> > 
> > Board info, ACPI, and ancillary device paths are not updated here.
> > Board info would require an API change to accept an array of CS values
> > and is left for a follow-up when we have a use case for this. Ancillary
> > devices are by design single-CS, so multi-CS is not a current use case for
> > them. ACPI represents the CS as a 64-bit integer with no established
> > convention for encoding multiple CS indices yet, so any extension there
> > would require a separate specification effort.
> > 
> > Acked-by: Nuno Sá <nuno.sa@analog.com>
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > Changes in v3:
> > * None.
> > 
> > Changes in v2:
> > * Include Summary describind why the other SPI paths were not addressed
> >   here.
> > ---
> >  drivers/spi/spi.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index d9e6b4b87c89..55fb96fea243 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1090,7 +1090,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
> >  	spi->controller->last_cs_index_mask = spi->cs_index_mask;
> >  	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++) {
> >  		if (enable && idx < spi->num_chipselect)
> > -			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
> > +			spi->controller->last_cs[idx] = spi_get_chipselect(spi, idx);
> >  		else
> >  			spi->controller->last_cs[idx] = SPI_INVALID_CS;
> >  	}
> > @@ -2594,10 +2594,11 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
> >  		spi_set_chipselect(spi, idx, cs[idx]);
> >  
> >  	/*
> > -	 * By default spi->chip_select[0] will hold the physical CS number,
> > -	 * so set bit 0 in spi->cs_index_mask.
> > +	 * Set cs_index_mask to indicate which logical CS indices are active.
> > +	 * Each bit corresponds to a logical CS index in the spi->chip_select array.
> >  	 */
> > -	spi->cs_index_mask = BIT(0);
> > +	for (idx = 0; idx < rc; idx++)
> > +		spi->cs_index_mask |= BIT(idx);
> >  
> >  	/* Device speed */
> >  	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
> 
> I have the same concern that sashiko calls out here.
> 
> Existing users of multi-cs (not including spi-mem) follow the pattern
> that a SPI device gets registered with the CS at index 0 and they later
> create an auxiliary using the additional CS. This would cause the main
> device to now assert both CS. Not what we want to happen.

Indeed, enalbing all CS for those cases would cause problems (like you
describe below). AD4080 would be an example.

The devicetree property seems to be a good ideia to fix this and simpler
to execute, but the composite device is interesting.

> 
> If I understood (and remember) the previous explanations of this series
> correctly, we have a different case for this one.
> 
> We want a main device that acts as a single composite device that asserts
> all 4 CS at the same time. Then we also need 4 auxiliary devices that
> only assert one CS at a time for configuring the individual chips.
> 
> So it seems to me like we need a new DT property or some way to be able to
> tell the difference to decide whether we just use the first CS here or all
> of them.
> 
> Perhaps another possibility would be to leave this code the way it is and
> do it this way instead:
> - The SPI device passed to the IIO driver is just the first chip (one CS)
> - The IIO driver then registers auxiliary drivers for the other 3 chips
>   (also 1 CS each)
> - These 4 devices will be used individual to handle configuration.
> - The IIO driver registers a separate composite device that has the
>   multiple lanes and and multiple CS. Whether this using the same
>   auxiliary mechanism with additional parameters or something new
>   probably doesn't matter too much.
> - In this way of doing things, it would not make sense to have the
>   spi-rx-bus-width property in the devcietree since as far as the
>   devicetree is concerned, these are more-or-less 4 separate devices
>   (from the SPI point of view).  Instead, this new composite device
>   registration function would be the one setting the number of lanes
>   based on the number of chip selects.
> 

My initial idea was to use the main device as the "composite" because it
holds the hw description, therefore the multi-lane would be handled by
the existing flow (that's why the spi-rx-bus-width property was
mandatory). This way each ancillary device would take the lane index
from the main device. Using the main + 3 ancillaries for individual
access and the new composite for simultaneous is a great alternative,
but removing the spi-rx-bus-width kind of excludes the information that
we are using multiple lanes for this device. Unless we document that 
"number of CS = number of lanes" on multiple-data-lanes.rst, the 
assumption is:

spi-rx-bus-width = <1>
spi-rx-lane-map = <1>

Also, it would make more sense to take the lane description from the
main device described in the DT considering cases like non-default
mapping. Or at least take it into consideration.
> ---
> sashiko output for reference:
> 
> --- Patch [2]: [PATCH v3 2/6] spi: support simultaneous assertion of multiple CS ---
> commit 17290644299c39d6ca397b14180cd885c5b04919
> Author: Jonathan Santos <Jonathan.Santos@analog.com>
> Subject: spi: support simultaneous assertion of multiple CS
> 
> This commit modifies spi_set_cs() and of_spi_parse_dt() to allow
> simultaneous toggling of multiple chip select lines. It builds
> cs_index_mask from all parsed CS entries instead of hardcoding
> bit 0.
> 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index d9e6b4b87c899..55fb96fea2432 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> 
> [ ... ]
> 
> > @@ -2594,10 +2594,11 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
> >  		spi_set_chipselect(spi, idx, cs[idx]);
> >  
> >  	/*
> > -	 * By default spi->chip_select[0] will hold the physical CS number,
> > -	 * so set bit 0 in spi->cs_index_mask.
> > +	 * Set cs_index_mask to indicate which logical CS indices are active.
> > +	 * Each bit corresponds to a logical CS index in the spi->chip_select array.
> >  	 */
> > -	spi->cs_index_mask = BIT(0);
> > +	for (idx = 0; idx < rc; idx++)
> > +		spi->cs_index_mask |= BIT(idx);
> 
> Will this loop break backward compatibility for devices that use multiple
> reg entries for independent logical chip selects?
> 
> For example, if a device has multiple reg entries and uses
> spi_new_ancillary_device(), the primary device's cs_index_mask will now have
> multiple bits set. During a transfer on the primary device, all of these
> parsed chip selects would be asserted simultaneously.
> 
> Could this result in multiple chips driving the shared MISO line at the same
> time, causing bus contention and data corruption?
> 

Yes, that could happen.

> >  
> >  	/* Device speed */
> >  	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
