From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v2] spi-fsl-dspi: Fix CTAR Register access
Date: Thu, 10 Dec 2015 08:15:14 +0100
Message-ID: <2295258.Vc5Dp4nsCT@ws-stein>
References: <1449726930-7378-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
	broonie@kernel.org, stefan@agner.ch, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449726930-7378-1-git-send-email-bhuvanchandra.dv@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday 10 December 2015 11:25:30, Bhuvanchandra DV wrote:
> DSPI instances in Vybrid have a different amount of chip selects
> and CTARs (Clock and transfer Attributes Register). In case of
> DSPI1 we only have 2 CTAR registers and 4 CS. In present driver
> implementation CTAR offset is derived from CS instance which will
> lead to out of bound access if chip select instance is greater than
> CTAR register instance, hence use single CTAR0 register for all CS
> instances. Since we write the CTAR register anyway before each access,
> there is no value in using the additional CTAR registers. Also one
> should not program a value in CTAS for a CTAR register that is not
> present, hence configure CTAS to use CTAR0.

Shouldn't the information put into struct fsl_dspi_devtype_data how much CTAR and CS the actual implementation has available? E.g. LS1021A has 6 CS and 4 CTAR

Best regards,
Alexander
-- 
-----
Please note our closure period for Christmas vacation and turn of the year
We are closed from 21st December 2015 to 3rd January 2016
-----
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010
