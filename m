From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-spi: Make spi-fsl-spi usable in cpu mode
	outside of FSL SOC environments and add a grlib variant normally
	running on sparc
Date: Wed, 30 Jan 2013 11:04:33 +0100
Message-ID: <5108F031.1010005@gaisler.com>
References: <1356711368-10437-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356711368-10437-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2012-12-28 17:16, Andreas Larsson wrote:
> This makes the cpu mode of the driver available outside of an FSL SOC
> and even powerpc environment. This is accomplished by putting things
> regarding fsl specific code and to cpm specific code within ifdefs.
>
> Furthermore, this adds support for the mostly register-compatible
> SPICTRL core from the GRLIB VHDL IP core library normally running on
> sparc. A different entry in of_fsl_spi_match matches this core and
> indicates a different hardware type that is used to set up different
> function pointers and special cases. The fetching of irq is changed to
> work under sparc as well.
>
> The GRLIB core operates in cpu mode and from the driver's point of view
> the important differences are that the number of bits per word might be
> limited and that there might be native chipselects selected via the
> added slvsel register. These differences if present are indicated by an
> added capabilities register.
>
> Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>

Any comments anyone?

This patch takes "Approach A" discussed and supported in 
http://sourceforge.net/mailarchive/message.php?msg_id=30131080

Cheers,
Andreas Larsson


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
