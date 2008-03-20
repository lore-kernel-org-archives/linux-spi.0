From: Hans Eklund <hans-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [spi-devel-general] spi_mmc bus
 concurrency fix
Date: Thu, 20 Mar 2008 12:22:42 +0100
Message-ID: <47E24902.70707@rubico.se>
References: <47C42D50.7020204@rubico.se>
	<200802272155.29706.david-b@pacbell.net> <47C66D8A.3010904@cox.net>
	<200803121501.19131.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <200803121501.19131.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell skrev:
> On Thursday 28 February 2008, Phil Wilshire wrote:
>> I agree, I did have some concerns about the callback issue.
>> It also looks like we have enough people + momentum on this problem to
>> get a fix in good time. So I'll wait to see what happens.
> =

> Actually, I'm not sure I'd agree on that.  Folk want a fix,
> but nobody (including me!) has sent something that's quite
> mergeable yet.
Hi again.

I have not solved the roots to the problem. Im not sure im the man to do =

that design in the end. But, I have actually MMC/SD cards running =

concurrently with m25p80 spi flash driver! No fix to either the master =

driver or the framework. Both reading and writing. No multiple block =

writings so far. But it is quite cool to see it spin.

It should be easy to move the solution over to the mainline mmc_spi =

driver once im satisfied with the implementation

you can see how i build the command and response transfers on before =

hand and then issue a single spi_sync to get it onto the bus under a =

single CS. I=B4ll have to add some more error detection and probably a =

status check after the busy poll phase in the end.

Hope to test it with enc28j60 driver this afternoon and send it to Phil =

who i believe was eager to test something.

/regards
Hans Eklund


static int spi_mmc_write_mmc_block(mmc_info_t* pdev, unsigned char* buf, =

unsigned int address)
{
	struct spi_transfer t[4];
	struct spi_message m;
	struct spi_message b;
	struct spi_transfer bt;
	int i=3D0;
	unsigned char wanted_token;

	#define MMC_CMD_LEN		6
	#define CMD_RESP_LEN		10
	#define TOKEN_AND_DATA_LEN	513
	#define DATA_RESP_LEN		100
	#define BUSY_BLOCK_LEN		64

	unsigned char mmc_cmd[MMC_CMD_LEN];
	unsigned char cmd_resp[CMD_RESP_LEN];
	unsigned char token_and_data[TOKEN_AND_DATA_LEN];
	unsigned char data_resp[DATA_RESP_LEN];
	unsigned char busy_block[BUSY_BLOCK_LEN];

	// Build write block command
	mmc_cmd[0] =3D 0x40 + 24;
	mmc_cmd[1] =3D (unsigned char)(address >> 24 & 0xff);
	mmc_cmd[2] =3D (unsigned char)(address >> 16 & 0xff);
	mmc_cmd[3] =3D (unsigned char)(address >> 8 & 0xff);
	mmc_cmd[4] =3D (unsigned char)(address & 0xff);
	mmc_cmd[5] =3D 0x95;	// CRC from CMD0 actually, but valid for all since =

SPI dont care

	// Build token+data chunk
	token_and_data[0] =3D (unsigned char)0xFE;	=

	memcpy(token_and_data+1, buf, TOKEN_AND_DATA_LEN-1);

	// Zero out messages
	spi_message_init(&m);
	memset(t, 0, (sizeof t));

	#ifdef CONFIG_BLACKFIN
	blackfin_dcache_flush_range((unsigned long)mmc_cmd,(unsigned =

long)(mmc_cmd+MMC_CMD_LEN));
	blackfin_dcache_flush_range((unsigned long)token_and_data,(unsigned =

long)(token_and_data+TOKEN_AND_DATA_LEN));
	#endif

	t[0].tx_buf =3D mmc_cmd;
	t[0].len =3D MMC_CMD_LEN;
	spi_message_add_tail(&t[0], &m);

	t[1].rx_buf =3D cmd_resp;
	t[1].len =3D CMD_RESP_LEN;
	spi_message_add_tail(&t[1], &m);

	t[2].tx_buf =3D token_and_data;
	t[2].len =3D TOKEN_AND_DATA_LEN;
	spi_message_add_tail(&t[2], &m);

	t[3].rx_buf =3D data_resp;
	t[3].len =3D DATA_RESP_LEN;
	spi_message_add_tail(&t[3], &m);

	// Send it away, Fingers crossed!
	spi_sync(pdev->spi_dev, &m);

	// Cache coherency stuff
	#ifdef CONFIG_BLACKFIN
	blackfin_dcache_invalidate_range((unsigned long)cmd_resp,(unsigned =

long)(cmd_resp+CMD_RESP_LEN));
	blackfin_dcache_invalidate_range((unsigned long)data_resp,(unsigned =

long)(data_resp+DATA_RESP_LEN));
	#endif

	// Analyze response buffers

	// R1_OK token
	wanted_token =3D 0x00;
	for(i=3D0; i<CMD_RESP_LEN; i++) {
		if(cmd_resp[i] =3D=3D wanted_token) {
			DPRINTK("Found wanted CMD token(0x%02x) at %d\n", cmd_resp[i], i);
			goto found_cmd_token;
		}
	}
	// error case here:
	DPRINTK("Did not find CMD response token!\n");
	return -1;

	// OK!
	found_cmd_token:

	// DR_ACCEPTED
	wanted_token =3D 0x05;
	for(i=3D0; i<DATA_RESP_LEN; i++) {
		if(data_resp[i] =3D=3D wanted_token || data_resp[i] =3D=3D 0x00 || =

data_resp[i] =3D=3D 0x01 || data_resp[i] =3D=3D 0x04) {
			DPRINTK("Found wanted DATA response token(0x%02x) at %d\n", =

data_resp[i], i);
			goto found_acc_token;
		}
	}
	// error case here:
	DPRINTK("Did not find DATA response token!\n");
	return -1;

	// OK!
	found_acc_token:

	// Read until NOT busy anymore
	i=3D1000;
	while(i--) {
		// it wont be done right away, be nice...
		schedule();
		memset(busy_block, 0, BUSY_BLOCK_LEN);
		spi_message_init(&b);
		memset(&bt, 0, (sizeof bt));
		bt.rx_buf =3D busy_block;
		bt.len =3D BUSY_BLOCK_LEN;
		spi_message_add_tail(&bt, &b);
		spi_sync(pdev->spi_dev, &b);
		blackfin_dcache_invalidate_range((unsigned long)busy_block,(unsigned =

long)(busy_block+BUSY_BLOCK_LEN));
		if(busy_block[BUSY_BLOCK_LEN-1] =3D=3D 0xFF) {
			DPRINTK("Detected transiton from busy to NOT busy, doNE!\n");
			goto done;
		}
	}
	printk("Busy transition timeout! Not good!");
	return -1;

	done:

	// Successfully wrote block to MMC!
	return 0;

}
