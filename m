From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC] spi: spi-fsl-spi: Making spi-fsl-spi partly
	platform-agnostic and adding a new mode for a new core
Date: Tue, 04 Dec 2012 11:07:32 +0100
Message-ID: <50BDCB64.90109@gaisler.com>
References: <1353576375-8560-1-git-send-email-andreas@gaisler.com>
	<50BDAD3A.3080505@gaisler.com>
	<OF994A4519.622141B3-ONC1257ACA.00321A60-C1257ACA.00327F5A@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OF994A4519.622141B3-ONC1257ACA.00321A60-C1257ACA.00327F5A-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2012-12-04 10:11, Joakim Tjernlund wrote:
> Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> wrote on 2012/12/04 08:58:50:
>> Any comments on this? A fair amount of rearranging and ifdefing would
>> be needed to make the spi-fsl-spi driver workable outside an fsl and
>> powerpc environment so I rather get some input before before trying
>> to perfect a solution that could not be acceptable into mainline.
>
> I am far from kernel devlopment ATM but I do have one comment, how to
> ensure this new combined driver doesn't break on existing powerpc
> systems?

Of course it would be preferable if the future patch would be tested on 
the original system to be sure nothing breaks.

Taking the "do everything inside the existing driver" approach could 
limit the risk of breaking anything by not moving things around. To get 
the driver to work outside an fsl environment ifdefs can be added in a 
way that the code would essentially be the same running on the original 
systems. Then, new branches that will never be taken on the original 
boards can handle the newly added mode.

This might not produce the most elegant code in the end though. The 
easiest way to make sure that nothing is broken is of course if I submit 
a completely separate driver, the downside being the duplicate 
code/functionality.

Cheers,
Andreas

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
