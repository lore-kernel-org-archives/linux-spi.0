From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
Date: Fri, 16 Sep 2016 10:28:38 -0500
Message-ID: <20160916152838.GA6795@rob-hp-laptop>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
 <293061a8-e867-4d91-20cb-6e5df8e9b543@suse.de>
 <4a199a95-3ee6-a3a0-bc8a-63bd0912e7d2@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org,
        linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4a199a95-3ee6-a3a0-bc8a-63bd0912e7d2-l3A5Bk7waGM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 08, 2016 at 02:50:37PM +0200, Andreas Färber wrote:
> Am 08.09.2016 um 14:04 schrieb Andreas Färber:
> > Am 08.09.2016 um 09:53 schrieb Neil Armstrong:
> >> This patchset adds a specific compatible string in the Meson SPIFC driver for
> >> the Amlogic Meson GXBB SoC.
> > 
> > Any particular reason? We could just reuse the meson6 one since there
> > appear to be no code changes so far.
> 
> So Neil is essentially telling me they don't know whether there are any
> differences in the IP block, so a separate compatible string was chosen.
> 
> No objection from my side, but a general clarification from device tree
> maintainers when and when not to would be appreciated. (+ devicetree)

New chip, always define a new compatible. If you think they are the same 
or are close enough to function with the existing driver, then put both 
compatible strings in the DT.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
