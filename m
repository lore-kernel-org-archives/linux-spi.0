From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI
 driver
Date: Thu, 22 Aug 2019 22:22:17 -0700
Message-ID: <20190823052217.GD2502@localhost>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
 <20190821043845.GB1332@localhost>
 <20190821140815.GA1447@localhost>
 <CA+h21hrtzU1XL-0m+BG5TYZvVh8WN6hgcM7CV5taHyq2MsR5dw@mail.gmail.com>
 <20190822141641.GB1437@localhost>
 <CA+h21hpJm-3svfV93pYYrpoiV12jDjuROHCgvCjPivAjXTB_VA@mail.gmail.com>
 <20190822160521.GC4522@localhost>
 <CA+h21hrELeUKbfGD3n=BL741QN9m3SaoJJ0y+q_uthdxvSFVRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Hubert Feurstein <h.feurstein@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hrELeUKbfGD3n=BL741QN9m3SaoJJ0y+q_uthdxvSFVRg@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 22, 2019 at 07:13:12PM +0300, Vladimir Oltean wrote:
> You do think that I understand the problem? But I don't!

;^)

> > And who generates Local_sync_resp?
> >
> 
> Local_sync_resp is the same as Local_sync_req except maybe with a
> custom tag added by the switch. Irrelevant as long as the DSA master
> can timestamp it.

So this is point why it won't work.  The time stamping logic in the
switch only recognizes PTP frames.
 
Thanks,
Richard
