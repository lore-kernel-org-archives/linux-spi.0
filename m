From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi: spi_mpc8xxx.c: fix potential
	memory corruption.
Date: Thu, 13 May 2010 15:50:45 +0200
Message-ID: <OFBFD4E293.5CD12DDB-ONC1257722.004B7601-C1257722.004C0EE3@transmode.se>
References: <1273679450-4185-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20100512162231.GA449@oksana.dev.rtsoft.ru>
	<OFB1D6A895.8E381278-ONC1257721.005A1E7B-C1257721.005A885D@transmode.se>
	<20100512164321.GA5522@oksana.dev.rtsoft.ru>
	<OFD4A1BD4A.1E890808-ONC1257722.00336F58-C1257722.0034C1F5@transmode.se>
	<20100513095545.GA11506@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100513095545.GA11506-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 2010/05/13 11:55:45:
>
> On Thu, May 13, 2010 at 11:36:15AM +0200, Joakim Tjernlund wrote:
> [...]
> > The new QE mode is so broken :(
> > Notice how the byte order is swapped for word = 16, 32
>
> *yawn*, it's not a news... :-) Remember QE-specific rx/tx_shift
> stuff?
>
> I'm sure the issue is related to how the QE SPI shift register
> works. I.e. SDMA just feeds the shift register, and it's shift
> register that is causing > 8 bits words to misbehave, or the
> issue is in how SDMA and shift registers connected.

This is how QE SPI defines bit and byte order:

[address%4=0x0_0x1_0x2_0x3] ghijklmn__opqrstuv_wxyzabcd_efGHIJKL
                                         Example 21-1.
with LEN=4 (data size=5),REV=0, the string transmitted is:
         first_bit nmlkj last_bit
with REV=1,the string transmitted is:
         first_bit jklmn    last_bit
                                         Example 21-2.
with LEN=7 (data size=8),REV=0, the string transmitted is:
         first_bit nmlkjihg last_bit
with REV=1, the string transmitted is:
         first_bit ghijklmn last_bit
                                         Example 21-3.
with LEN=0xC (data size=13),REV=0, the string transmitted is:
         first_bit nmlkjihgvutsr last_bit
with REV=1, the string transmitted is:
         first_bit rstuvghijklmn last_bit
                                         Example 21-4.
with LEN=0xF (data size=16), REV=0, the string transmitted is:
         first_bit nmlkjihgvutsrqpo last_bit
with REV=1, the string transmitted is:
         first_bit opqrstuvghijklmn last_bit
                                         Example 21-5.
with LEN=0 (data size=32), REV=0, the string transmitted is:
         first_bit nmlkjihgvutsrqpodcbazyxwLKJIHGfe last_bit
with REV=1, the string transmitted is:
         first_bit efGHIJKLwxyzabcdopqrstuvghijklmn last_bit


Seems to correspond to what I am seeing but is this a sane definition?
If so, then the CPU mode is wrong and needs to be changed.


------------------------------------------------------------------------------
